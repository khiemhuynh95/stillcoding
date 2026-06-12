-- Daily sync schedule.
--
-- pg_cron runs the job inside Postgres; pg_net lets it make an HTTP call to the
-- sync-problems Edge Function, which does the actual API fetch + upsert.
--
-- Before running this migration, store your project ref and the service-role
-- key in Vault so they aren't hard-coded here:
--
--   select vault.create_secret('https://<PROJECT_REF>.supabase.co', 'project_url');
--   select vault.create_secret('<SERVICE_ROLE_KEY>',                 'service_role_key');
--
-- (Re-run create_secret only once; use vault.update_secret to change them.)

create extension if not exists pg_cron;
create extension if not exists pg_net;
create extension if not exists supabase_vault;

-- Remove a previous definition so this migration is re-runnable.
select cron.unschedule('sync-problems-daily')
where exists (select 1 from cron.job where jobname = 'sync-problems-daily');

-- Every day at 06:00 UTC, POST to the Edge Function.
select cron.schedule(
  'sync-problems-daily',
  '0 6 * * *',
  $$
  select net.http_post(
    url     := (select decrypted_secret from vault.decrypted_secrets where name = 'project_url')
               || '/functions/v1/sync-problems',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer ' ||
        (select decrypted_secret from vault.decrypted_secrets where name = 'service_role_key')
    ),
    body    := '{}'::jsonb,
    timeout_milliseconds := 290000
  );
  $$
);

-- Inspect runs:
--   select * from cron.job;
--   select * from cron.job_run_details order by start_time desc limit 10;
--   select * from public.sync_runs order by started_at desc limit 10;
