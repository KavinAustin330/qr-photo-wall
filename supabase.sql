-- Run this in Supabase > SQL Editor.
create table if not exists public.photos (
  id uuid primary key default gen_random_uuid(),
  image_url text not null,
  storage_path text not null,
  uploader_name text,
  caption text,
  approved boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.photos enable row level security;

drop policy if exists "Anyone can view approved photos" on public.photos;
create policy "Anyone can view approved photos" on public.photos for select using (approved = true);

drop policy if exists "Anyone can add photos" on public.photos;
create policy "Anyone can add photos" on public.photos for insert with check (
  char_length(coalesce(uploader_name,'')) <= 50 and char_length(coalesce(caption,'')) <= 200
);

-- Create a PUBLIC Storage bucket named: photos
-- Then add these Storage policies in the dashboard or run the following after the bucket exists.
drop policy if exists "Public photo uploads" on storage.objects;
create policy "Public photo uploads" on storage.objects for insert to anon with check (bucket_id = 'photos');

drop policy if exists "Public photo reads" on storage.objects;
create policy "Public photo reads" on storage.objects for select to public using (bucket_id = 'photos');

-- Enable Realtime for this table in Database > Replication / Publications.
-- SECURITY NOTE: anonymous DELETE is intentionally NOT enabled.
-- admin.html therefore requires authenticated/admin policies before deletion will work.
