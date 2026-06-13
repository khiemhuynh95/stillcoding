import type { Metadata } from "next";
import "./globals.css";
import { QueryProvider } from "@/providers/QueryProvider";
import { Analytics } from '@vercel/analytics/next';

export const metadata: Metadata = {
  title: "StillCoding — Browse Challenges",
  description: "Browse coding problems and write solutions.",
};

// Restore the persisted theme before first paint to avoid a flash.
const themeScript = `try{var t=JSON.parse(localStorage.getItem('devstudio:theme'));if(t==='dark'){document.documentElement.classList.add('dark');}}catch(e){}`;

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link
          rel="preconnect"
          href="https://fonts.gstatic.com"
          crossOrigin="anonymous"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Plus+Jakarta+Sans:wght@600;700;800&family=JetBrains+Mono:wght@400&display=swap"
          rel="stylesheet"
        />
        {/*
          The app only ever varies the FILL axis (via the `.fill` class); opsz,
          weight and grade are fixed by globals.css. Pinning those three to single
          values ships a much smaller icon font. `display=block` avoids a flash of
          the raw ligature text (e.g. "search") before the font loads.
        */}
        <link
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0&display=block"
          rel="stylesheet"
        />
        <script dangerouslySetInnerHTML={{ __html: themeScript }} />
      </head>
      <body className="bg-background text-on-surface font-body-md">
        <QueryProvider>{children}</QueryProvider>
        <Analytics />
      </body>
    </html>
  );
}
