"use client";

import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useAuth } from "@/providers/AuthProvider";
import {
  addProblemToWeek,
  createCourse,
  createInvite,
  createWeek,
  deleteWeek,
  fetchCourse,
  fetchInvites,
  fetchLeaderboard,
  fetchMembers,
  fetchMyCourses,
  fetchMyProgress,
  fetchWeeks,
  joinCourse,
  leaveCourse,
  removeMember,
  removeProblemFromWeek,
  renameWeek,
  reorderWeekProblems,
  revokeInvite,
  setMemberRole,
  updateCourse,
} from "@/lib/course";
import type { CourseRole } from "@/lib/types";

/**
 * TanStack Query wrappers for the course data layer. All keys live under
 * ["course", ...] so mutations can invalidate coarsely. Queries are disabled
 * until the auth session has resolved to a signed-in user.
 */

const FIVE_MIN = 5 * 60 * 1000;

export function useMyCourses() {
  const { user, profile, loading } = useAuth();
  const isAppAdmin = profile?.isAdmin ?? false;
  return useQuery({
    // isAppAdmin is in the key: the flag arrives with the async profile fetch
    // and flips the query from "my courses" to "all courses".
    queryKey: ["course", "mine", user?.id, isAppAdmin],
    queryFn: () => fetchMyCourses(user!.id, isAppAdmin),
    staleTime: FIVE_MIN,
    enabled: !loading && Boolean(user),
  });
}

/** Accepts the join code (used in URLs) or the internal uuid. */
export function useCourse(codeOrId: string) {
  const { user, profile, loading } = useAuth();
  const isAppAdmin = profile?.isAdmin ?? false;
  return useQuery({
    queryKey: ["course", "detail", codeOrId, user?.id, isAppAdmin],
    queryFn: () => fetchCourse(codeOrId, user!.id, isAppAdmin),
    staleTime: FIVE_MIN,
    enabled: !loading && Boolean(user) && Boolean(codeOrId),
  });
}

export function useCourseWeeks(courseId: string) {
  const { user, loading } = useAuth();
  return useQuery({
    queryKey: ["course", "weeks", courseId],
    queryFn: () => fetchWeeks(courseId),
    staleTime: FIVE_MIN,
    enabled: !loading && Boolean(user) && Boolean(courseId),
  });
}

export function useMyProgress(courseId: string) {
  const { user, loading } = useAuth();
  return useQuery({
    queryKey: ["course", "progress", courseId, user?.id],
    queryFn: () => fetchMyProgress(courseId, user!.id),
    staleTime: 30 * 1000,
    enabled: !loading && Boolean(user) && Boolean(courseId),
  });
}

export function useCourseMembers(courseId: string) {
  const { user, loading } = useAuth();
  return useQuery({
    queryKey: ["course", "members", courseId],
    queryFn: () => fetchMembers(courseId),
    staleTime: FIVE_MIN,
    enabled: !loading && Boolean(user) && Boolean(courseId),
  });
}

export function useCourseInvites(courseId: string) {
  const { user, loading } = useAuth();
  return useQuery({
    queryKey: ["course", "invites", courseId],
    queryFn: () => fetchInvites(courseId),
    staleTime: FIVE_MIN,
    enabled: !loading && Boolean(user) && Boolean(courseId),
  });
}

export function useLeaderboard(courseId: string) {
  const { user, loading } = useAuth();
  return useQuery({
    queryKey: ["course", "leaderboard", courseId],
    queryFn: () => fetchLeaderboard(courseId),
    // Fresher than the default so new completions show up quickly.
    staleTime: 30 * 1000,
    enabled: !loading && Boolean(user) && Boolean(courseId),
  });
}

/** Invalidate every course query (coarse, but course data is small). */
function useInvalidateCourses() {
  const queryClient = useQueryClient();
  return () => queryClient.invalidateQueries({ queryKey: ["course"] });
}

export function useCreateCourse() {
  const invalidate = useInvalidateCourses();
  return useMutation({
    mutationFn: (input: {
      name: string;
      description?: string;
      startDate?: string | null;
      endDate?: string | null;
    }) => createCourse(input),
    onSuccess: invalidate,
  });
}

export function useUpdateCourse(courseId: string) {
  const invalidate = useInvalidateCourses();
  return useMutation({
    mutationFn: (patch: {
      name?: string;
      description?: string;
      startDate?: string | null;
      endDate?: string | null;
    }) => updateCourse(courseId, patch),
    onSuccess: invalidate,
  });
}

export function useJoinCourse() {
  const invalidate = useInvalidateCourses();
  return useMutation({
    mutationFn: (joinCode: string) => joinCourse(joinCode),
    onSuccess: invalidate,
  });
}

export function useLeaveCourse() {
  const { user } = useAuth();
  const invalidate = useInvalidateCourses();
  return useMutation({
    mutationFn: (courseId: string) => leaveCourse(courseId, user!.id),
    onSuccess: invalidate,
  });
}

export function useWeekMutations(courseId: string) {
  const invalidate = useInvalidateCourses();
  const create = useMutation({
    mutationFn: (input: { title: string; position: number }) =>
      createWeek(courseId, input.title, input.position),
    onSuccess: invalidate,
  });
  const rename = useMutation({
    mutationFn: (input: { weekId: string; title: string }) =>
      renameWeek(input.weekId, input.title),
    onSuccess: invalidate,
  });
  const remove = useMutation({
    mutationFn: (weekId: string) => deleteWeek(weekId),
    onSuccess: invalidate,
  });
  const addProblem = useMutation({
    mutationFn: (input: { weekId: string; titleSlug: string; position: number }) =>
      addProblemToWeek(input.weekId, input.titleSlug, input.position),
    onSuccess: invalidate,
  });
  const removeProblem = useMutation({
    mutationFn: (problemId: string) => removeProblemFromWeek(problemId),
    onSuccess: invalidate,
  });
  const reorder = useMutation({
    mutationFn: (orderedProblemIds: string[]) =>
      reorderWeekProblems(orderedProblemIds),
    onSuccess: invalidate,
  });
  return { create, rename, remove, addProblem, removeProblem, reorder };
}

export function useMemberMutations(courseId: string) {
  const invalidate = useInvalidateCourses();
  const remove = useMutation({
    mutationFn: (userId: string) => removeMember(courseId, userId),
    onSuccess: invalidate,
  });
  const changeRole = useMutation({
    mutationFn: (input: { userId: string; role: CourseRole }) =>
      setMemberRole(courseId, input.userId, input.role),
    onSuccess: invalidate,
  });
  const invite = useMutation({
    mutationFn: (input: { email: string; role: CourseRole }) =>
      createInvite(courseId, input.email, input.role),
    onSuccess: invalidate,
  });
  const revoke = useMutation({
    mutationFn: (inviteId: string) => revokeInvite(inviteId),
    onSuccess: invalidate,
  });
  return { remove, changeRole, invite, revoke };
}
