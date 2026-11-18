(function () {
  const nav = document.getElementById('nav');
  const prog = document.getElementById('prog');
  let tick = false;
  addEventListener('scroll', function () {
    if (tick) return;
    tick = true;
    requestAnimationFrame(function () {
      const y = scrollY, h = document.documentElement.scrollHeight - innerHeight;
      if (prog) prog.style.width = (h > 0 ? (y / h) * 100 : 0) + '%';
      if (nav) nav.classList.toggle('solid', y > 40);
      tick = false;
    });
  }, { passive: true });

  const panel = document.getElementById('panel');
  const scrim = document.getElementById('scrim');
  if (!panel || !scrim) return;
  const $ = function (id) { return document.getElementById(id); };
  const WA = window.WA_NUMBER || '50760990195';
  let lastFocus = null;

  function open(slug, origin) {
    lastFocus = origin;
    fetch('/api/producto/' + encodeURIComponent(slug))
      .then(function (r) { return r.ok ? r.json() : Promise.reject(); })
      .then(function (p) {
        $('d-img').src = p.image || '';
        $('d-img').alt = (p.name || '') + ' ' + (p.brand || '');
        $('d-brand').textContent = p.brand || '';
        $('d-name').textContent = p.name || '';
        $('d-tag').textContent = p.excerpt || '';
        $('d-cat').textContent = p.category || '—';
        $('d-br').textContent = p.brand || '—';
        $('d-stock').textContent = (p.stock_status === 'instock') ? 'Disponible' : 'Agotado';
        $('d-desc').textContent = p.excerpt || '';
        $('d-price').textContent = p.price ? ('$' + Number(p.price).toFixed(2) + ' USD') : 'Consultar';
        const msg = 'Hola, me interesa ' + (p.name || '') + ' (' + (p.brand || '') + '). ¿Está disponible?';
        $('d-wa').href = 'https://wa.me/' + WA + '?text=' + encodeURIComponent(msg);
        $('d-page').href = '/producto/' + p.slug + '/';
        panel.classList.add('on');
        scrim.classList.add('on');
        document.body.style.overflow = 'hidden';
        panel.focus();
      })
      .catch(function () { window.location.href = '/producto/' + slug + '/'; });
  }

  function close() {
    panel.classList.remove('on');
    scrim.classList.remove('on');
    document.body.style.overflow = '';
    if (lastFocus) lastFocus.focus();
  }

  document.addEventListener('click', function (e) {
    const card = e.target.closest('.card');
    if (card && card.dataset.slug && !e.metaKey && !e.ctrlKey && e.button === 0) {
      e.preventDefault();
      open(card.dataset.slug, card);
    }
  });
  $('d-close').addEventListener('click', close);
  scrim.addEventListener('click', close);
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && panel.classList.contains('on')) close();
  });
})();
