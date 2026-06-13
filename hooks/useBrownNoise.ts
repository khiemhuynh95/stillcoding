"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { storageKeys } from "@/lib/storage";
import { useLocalStorage } from "./useLocalStorage";

/**
 * Procedurally-generated brown noise via the Web Audio API — no audio asset to
 * ship. A 10s looping buffer of integrated white noise keeps the loop seam rare
 * and unnoticeable. The audio graph is created lazily on first play and torn
 * down on unmount, so playback stops automatically when the editor page closes.
 *
 * Volume and the auto-play preference persist across sessions in localStorage.
 */
export function useBrownNoise() {
  const [autoPlay, setAutoPlay] = useLocalStorage<boolean>(
    storageKeys.noiseAutoPlay,
    false,
  );
  const [volume, setVolume] = useLocalStorage<number>(
    storageKeys.noiseVolume,
    0.4,
  );
  // Low-pass cutoff in Hz: lower = darker/sleepier, higher = brighter/fuller.
  const [tone, setTone] = useLocalStorage<number>(storageKeys.noiseTone, 500);
  const [playing, setPlaying] = useState(false);

  const ctxRef = useRef<AudioContext | null>(null);
  const gainRef = useRef<GainNode | null>(null);
  const filterRef = useRef<BiquadFilterNode | null>(null);
  const sourceRef = useRef<AudioBufferSourceNode | null>(null);
  // Latest values, so start() reads them without becoming a dependency.
  const volumeRef = useRef(volume);
  volumeRef.current = volume;
  const toneRef = useRef(tone);
  toneRef.current = tone;

  const ensureGraph = useCallback(() => {
    if (ctxRef.current) return ctxRef.current;
    const AudioCtx =
      window.AudioContext ||
      (window as unknown as { webkitAudioContext: typeof AudioContext })
        .webkitAudioContext;
    const ctx = new AudioCtx();
    // Canonical brown noise is correct but full; a gentle low-pass rolls off the
    // harsh top end for a calmer rumble without altering the noise color much.
    const filter = ctx.createBiquadFilter();
    filter.type = "lowpass";
    filter.frequency.value = toneRef.current;
    filter.Q.value = 0.707; // Butterworth — flat passband, no resonant peak
    const gain = ctx.createGain();
    gain.gain.value = volumeRef.current;
    filter.connect(gain);
    gain.connect(ctx.destination);
    ctxRef.current = ctx;
    gainRef.current = gain;
    filterRef.current = filter;
    return ctx;
  }, []);

  const start = useCallback(async () => {
    const ctx = ensureGraph();
    // Autoplay policies leave the context suspended until a user gesture.
    if (ctx.state === "suspended") {
      try {
        await ctx.resume();
      } catch {
        /* will resume on the next user gesture */
      }
    }
    setPlaying(true);
    if (sourceRef.current) return; // already running

    const seconds = 10;
    const size = ctx.sampleRate * seconds;
    const buffer = ctx.createBuffer(1, size, ctx.sampleRate);
    const data = buffer.getChannelData(0);
    let last = 0;
    for (let i = 0; i < size; i++) {
      const white = Math.random() * 2 - 1;
      // Canonical brown-noise leaky integrator (spectrally correct −12dB/oct).
      last = (last + 0.02 * white) / 1.02;
      data[i] = last * 3.5; // compensate for the integrator's low gain
    }

    const src = ctx.createBufferSource();
    src.buffer = buffer;
    src.loop = true;
    src.connect(filterRef.current!);
    src.start();
    sourceRef.current = src;
  }, [ensureGraph]);

  const stop = useCallback(() => {
    if (sourceRef.current) {
      try {
        sourceRef.current.stop();
      } catch {
        /* already stopped */
      }
      sourceRef.current.disconnect();
      sourceRef.current = null;
    }
    setPlaying(false);
  }, []);

  const toggle = useCallback(() => {
    if (playing) stop();
    else void start();
  }, [playing, start, stop]);

  // Smoothly track volume changes while playing.
  useEffect(() => {
    const ctx = ctxRef.current;
    const gain = gainRef.current;
    if (ctx && gain) gain.gain.setTargetAtTime(volume, ctx.currentTime, 0.02);
  }, [volume]);

  // Track tone (low-pass cutoff) changes while playing.
  useEffect(() => {
    const ctx = ctxRef.current;
    const filter = filterRef.current;
    if (ctx && filter)
      filter.frequency.setTargetAtTime(tone, ctx.currentTime, 0.02);
  }, [tone]);

  // Auto-play on mount when enabled. If the browser blocks the initial resume,
  // fall back to starting on the first user gesture.
  useEffect(() => {
    if (!autoPlay) return;
    void start();
    const ctx = ctxRef.current;
    if (!ctx || ctx.state === "running") return;

    const resume = () => void ctx.resume();
    window.addEventListener("pointerdown", resume, { once: true });
    window.addEventListener("keydown", resume, { once: true });
    return () => {
      window.removeEventListener("pointerdown", resume);
      window.removeEventListener("keydown", resume);
    };
    // Run once on mount; `start` is stable and autoPlay is read at mount time.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Tear the graph down when the consumer unmounts (i.e. leaving the page).
  useEffect(() => {
    return () => {
      if (sourceRef.current) {
        try {
          sourceRef.current.stop();
        } catch {
          /* ignore */
        }
        sourceRef.current.disconnect();
        sourceRef.current = null;
      }
      void ctxRef.current?.close();
      ctxRef.current = null;
      gainRef.current = null;
      filterRef.current = null;
    };
  }, []);

  return {
    playing,
    toggle,
    volume,
    setVolume,
    tone,
    setTone,
    autoPlay,
    setAutoPlay,
  } as const;
}
