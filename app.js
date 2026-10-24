const C=window.APP_CONFIG;
const configured=()=>C.SUPABASE_URL&&!C.SUPABASE_URL.startsWith('YOUR_')&&C.SUPABASE_ANON_KEY&&!C.SUPABASE_ANON_KEY.startsWith('YOUR_');
const sb=()=>window.supabase.createClient(C.SUPABASE_URL,C.SUPABASE_ANON_KEY);
const esc=s=>String(s??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));
function setupNotice(el){if(!configured()){el.innerHTML='<div class="setup"><strong>Setup required:</strong> open <code>config.js</code> and add your Supabase Project URL and anon key. See README.md.</div>';return true}return false}
function photoCard(p,admin=false){return `<article class="photo" data-id="${p.id}"><img loading="lazy" src="${esc(p.image_url)}" alt="Shared photo"><div class="meta">${p.uploader_name?`<strong>${esc(p.uploader_name)}</strong>`:''}${p.caption?`<p>${esc(p.caption)}</p>`:''}</div>${admin?`<div class="admin-tools"><button class="btn danger delete" data-id="${p.id}" data-path="${esc(p.storage_path)}">Delete</button></div>`:''}</article>`}
