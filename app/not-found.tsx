import Link from "next/link";

export default function NotFound() {
  return (
    <div className="h-screen flex flex-col items-center justify-center text-center px-6 gap-4 bg-background">
      <span className="material-symbols-outlined text-6xl text-outline-variant">
        explore_off
      </span>
      <h1 className="font-headline-sm text-headline-sm text-on-surface">
        Page not found
      </h1>
      <p className="text-body-md text-on-surface-variant max-w-sm">
        The page you&apos;re looking for doesn&apos;t exist or has moved.
      </p>
      <Link
        href="/"
        className="px-5 py-2.5 bg-primary text-on-primary rounded text-label-md font-label-md hover:opacity-90"
      >
        Back to browse
      </Link>
    </div>
  );
}
