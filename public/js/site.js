/* Soft Car Service — skrypty frontu (bez jQuery). */
(function () {
  'use strict';

  /* ---------------- menu mobilne (szuflada) + rozwijane ---------------- */
  var DRAWER_MAX = 1199;

  function buildDrawer(nav) {
    if (nav.parentElement.classList.contains('dn-container')) return;
    var wrap = document.createElement('div');
    wrap.className = 'dn-container';
    nav.parentElement.insertBefore(wrap, nav);
    wrap.appendChild(nav);
    nav.classList.add('dn-nav', 'dn-nav-overlay', 'dn-nav-left-right');
    nav.style.width = '100%';

    var close = document.createElement('button');
    close.type = 'button';
    close.className = 'dn-close';
    close.setAttribute('aria-controls', nav.id);
    close.setAttribute('aria-expanded', 'false');
    close.setAttribute('aria-label', 'Zamknij menu');
    close.innerHTML = '<span class="dn-close-line"></span><span class="dn-close-line"></span>';
    close.addEventListener('click', function () { setDrawer(nav, false); });
    nav.insertBefore(close, nav.firstChild);

    var root = nav.querySelector('ul.nav');
    if (root) root.classList.add('dn-list', 'dn-list-root');
  }

  function destroyDrawer(nav) {
    var wrap = nav.parentElement;
    if (!wrap || !wrap.classList.contains('dn-container')) return;
    nav.classList.remove('dn-nav', 'dn-nav-overlay', 'dn-nav-left-right', 'dn-nav-open');
    nav.style.width = '';
    var close = nav.querySelector('.dn-close');
    if (close) close.remove();
    var root = nav.querySelector('ul.nav');
    if (root) root.classList.remove('dn-list', 'dn-list-root');
    wrap.parentElement.insertBefore(nav, wrap);
    wrap.remove();
  }

  function setDrawer(nav, open) {
    nav.classList.toggle('dn-nav-open', open);
    document.querySelectorAll('[aria-controls="' + nav.id + '"]').forEach(function (b) {
      b.setAttribute('aria-expanded', open ? 'true' : 'false');
      if (b.classList.contains('navbar-toggle')) b.classList.toggle('collapsed', !open);
    });
  }

  function initMenu() {
    document.querySelectorAll('.navbar-toggle').forEach(function (btn) {
      var nav = document.getElementById(btn.getAttribute('aria-controls'));
      if (!nav) return;
      btn.classList.add('dn-toggle-custom');
      btn.setAttribute('aria-label', 'Otwórz/zamknij menu');
      btn.addEventListener('click', function () {
        setDrawer(nav, !nav.classList.contains('dn-nav-open'));
      });

      function sync() {
        if (window.innerWidth <= DRAWER_MAX) buildDrawer(nav);
        else { setDrawer(nav, false); destroyDrawer(nav); }
      }
      sync();
      window.addEventListener('resize', sync);
    });

    document.querySelectorAll('li.dropdown > .dropdown-toggle').forEach(function (a) {
      a.addEventListener('click', function (e) {
        e.preventDefault();
        var li = a.parentElement;
        var open = li.classList.contains('open');
        document.querySelectorAll('li.dropdown.open').forEach(function (x) { if (x !== li) x.classList.remove('open'); });
        li.classList.toggle('open', !open);
        a.setAttribute('aria-expanded', !open ? 'true' : 'false');
      });
    });
    document.addEventListener('click', function (e) {
      if (!e.target.closest('li.dropdown')) {
        document.querySelectorAll('li.dropdown.open').forEach(function (x) { x.classList.remove('open'); });
      }
    });
    document.addEventListener('keydown', function (e) {
      if (e.key !== 'Escape') return;
      document.querySelectorAll('.dn-nav-open').forEach(function (n) { setDrawer(n, false); });
    });
  }

  /* ---------------- slider (zgodny z DOM slick) ---------------- */
  function initSlider(root) {
    var slides = Array.prototype.filter.call(root.children, function (el) {
      return /^slide\d*$/.test(el.className.trim().split(' ')[0]) || el.hasAttribute('data-type');
    });
    if (slides.length === 0) return;

    var list = document.createElement('div');
    list.className = 'slick-list draggable';
    var track = document.createElement('div');
    track.className = 'slick-track';
    list.appendChild(track);
    var cells = slides.map(function (s) {
      var cell = document.createElement('div');
      cell.className = 'slick-slide';
      s.style.width = '100%';
      s.style.display = 'block';
      cell.appendChild(s);
      track.appendChild(cell);
      return cell;
    });
    root.appendChild(list);
    root.classList.add('slick-initialized', 'slick-slider');

    var dots = null;
    if (slides.length > 1) {
      root.classList.add('slick-dotted');
      dots = document.createElement('ul');
      dots.className = 'slick-dots';
      dots.setAttribute('role', 'tablist');
      slides.forEach(function (_, i) {
        var li = document.createElement('li');
        li.setAttribute('role', 'presentation');
        var b = document.createElement('button');
        b.type = 'button';
        b.setAttribute('role', 'tab');
        b.setAttribute('aria-label', (i + 1) + ' of ' + slides.length);
        b.textContent = String(i + 1);
        b.addEventListener('click', function () { go(i, true); });
        li.appendChild(b);
        dots.appendChild(li);
      });
      root.appendChild(dots);

      ['prev', 'next'].forEach(function (dir) {
        var btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'slick-' + dir + ' slick-arrow';
        btn.setAttribute('aria-label', dir === 'prev' ? 'Poprzedni slajd' : 'Następny slajd');
        btn.textContent = dir === 'prev' ? 'Previous' : 'Next';
        btn.style.display = 'block';
        btn.addEventListener('click', function () { go(cur + (dir === 'prev' ? -1 : 1), true); });
        root.appendChild(btn);
      });
    }

    var cur = 0, timer = null, paused = false;

    function layout() {
      var w = root.clientWidth;
      track.style.opacity = '1';
      track.style.width = (w * slides.length) + 'px';
      cells.forEach(function (s, i) {
        s.style.width = w + 'px';
        s.style.position = 'relative';
        s.style.left = (-w * i) + 'px';
        s.style.top = '0px';
        s.style.display = 'block';
        s.style.zIndex = i === cur ? '999' : '998';
        s.style.opacity = i === cur ? '1' : '0';
      });
    }

    function go(i, user) {
      cur = (i + slides.length) % slides.length;
      cells.forEach(function (s, k) {
        s.classList.toggle('slick-current', k === cur);
        s.classList.toggle('slick-active', k === cur);
        s.style.zIndex = k === cur ? '999' : '998';
        s.style.opacity = k === cur ? '1' : '0';
      });
      if (dots) {
        Array.prototype.forEach.call(dots.children, function (li, k) {
          li.classList.toggle('slick-active', k === cur);
          li.firstChild.setAttribute('aria-selected', k === cur ? 'true' : 'false');
        });
      }
      if (user) restart();
    }

    function restart() {
      clearInterval(timer);
      if (slides.length > 1) timer = setInterval(function () { if (!paused) go(cur + 1); }, 7000);
    }

    root.addEventListener('mouseenter', function () { paused = true; });
    root.addEventListener('mouseleave', function () { paused = false; });
    window.addEventListener('resize', layout);

    layout();
    go(0);
    restart();
  }

  /* ---------------- liczniki ---------------- */
  function initCounters() {
    var els = document.querySelectorAll('[data-counter]');
    if (!els.length) return;
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (!e.isIntersecting) return;
        io.unobserve(e.target);
        var el = e.target;
        var to = parseInt(el.getAttribute('data-counter'), 10) || 0;
        var dur = 1600, t0 = performance.now();
        (function step(t) {
          var k = Math.min(1, (t - t0) / dur);
          el.textContent = String(Math.round(to * (1 - Math.pow(1 - k, 3))));
          if (k < 1) requestAnimationFrame(step);
        })(t0);
      });
    }, { threshold: 0.3 });
    els.forEach(function (el) { io.observe(el); });
  }

  /* ---------------- pasek przewijany ---------------- */
  function initMarquee() {
    document.querySelectorAll('.marquee').forEach(function (m) {
      var inner = m.querySelector('.js-marquee');
      if (!inner) return;
      var wrap = document.createElement('div');
      wrap.className = 'js-marquee-wrapper';
      m.insertBefore(wrap, inner);
      wrap.appendChild(inner);
      var clone = inner.cloneNode(true);
      wrap.appendChild(clone);
      var w = inner.offsetWidth + 20;
      wrap.style.setProperty('--marquee-width', w + 'px');
      wrap.style.animationDuration = Math.max(10, w / 60) + 's';
    });
  }

  /* ---------------- galeria (uklad kaskadowy, jak w starym DropPics) ---------------- */
  function layoutGallery(box) {
    var items = [].slice.call(box.querySelectorAll('.wimg'));
    if (!items.length) return;
    var gap = 10;
    var itemW = items[0].offsetWidth || 200;
    var avail = (box.parentElement || box).clientWidth || itemW;
    var cols = Math.max(1, Math.floor((avail + gap) / (itemW + gap)));
    var heights = new Array(cols).fill(0);
    items.forEach(function (it) {
      var min = heights.indexOf(Math.min.apply(null, heights));
      it.style.position = 'absolute';
      it.style.left = min * (itemW + gap) + 'px';
      it.style.top = heights[min] + 'px';
      heights[min] += it.offsetHeight + gap;
    });
    box.style.position = 'relative';
    box.style.width = cols * (itemW + gap) - gap + 'px';
    box.style.height = Math.max.apply(null, heights) + 'px';
  }

  function initGallery() {
    var boxes = document.querySelectorAll('.droppicspictures');
    if (!boxes.length) return;
    function run() { boxes.forEach(layoutGallery); }
    run();
    window.addEventListener('resize', run);
    document.querySelectorAll('.droppicspictures img').forEach(function (img) {
      if (img.complete) return;
      img.addEventListener('load', run, { once: true });
    });
  }

  /* ---------------- tabele przewijane w poziomie na waskich ekranach ---------------- */
  function initTables() {
    document.querySelectorAll('article.item-page table').forEach(function (t) {
      if (t.parentElement.classList.contains('table-responsive')) return;
      var w = document.createElement('div');
      w.className = 'table-responsive';
      t.parentElement.insertBefore(w, t);
      w.appendChild(t);
    });
  }

  /* ---------------- ikony social: na telefonie chowane pod przyciskiem ---------------- */
  function initSocial() {
    var box = document.querySelector('.social-icons-container');
    if (!box) return;
    var ul = box.querySelector('ul.social-icons');
    var btn = box.querySelector('.mobile-button');
    if (!ul || !btn) return;
    var open = false;
    function apply() {
      var mobile = window.innerWidth < 768;
      ul.style.display = !mobile || open ? '' : 'none';
      btn.style.display = mobile ? '' : 'none';
    }
    function toggle() { open = !open; apply(); }
    btn.addEventListener('click', toggle);
    btn.addEventListener('keydown', function (e) { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); toggle(); } });
    window.addEventListener('resize', function () { open = false; apply(); });
    apply();
  }

  /* ---------------- do góry ---------------- */
  function initGoTop() {
    document.querySelectorAll('.fixed-up').forEach(function (el) {
      el.addEventListener('click', function () { window.scrollTo({ top: 0, behavior: 'smooth' }); });
      el.addEventListener('keydown', function (e) { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); window.scrollTo({ top: 0, behavior: 'smooth' }); } });
    });
    var box = document.querySelector('.block104');
    if (!box) return;
    function upd() { box.classList.toggle('is-visible', window.scrollY > 400); }
    window.addEventListener('scroll', upd, { passive: true });
    upd();
  }

  /* stary szablon dokladal te klasy skryptem — powtarzamy, bo CSS na nich polega */
  function initButtons() {
    document.querySelectorAll('a.btn, button.btn').forEach(function (el) {
      if (!el.classList.contains('border-radius-sm')) el.classList.add('border-radius-sm');
      if (!el.classList.contains('btn-shadow')) el.classList.add('btn-shadow');
    });
  }

  /* strzalka rozwijania menu: widoczna tylko w widoku mobilnym */
  function initDropdownVisibility() {
    var toggles = document.querySelectorAll('li.dropdown > a.dropdown-toggle');
    function upd() {
      var mobile = window.innerWidth < 1200;
      toggles.forEach(function (t) { t.style.display = mobile ? '' : 'none'; });
    }
    upd();
    window.addEventListener('resize', upd);
  }

  /* Rownanie wysokosci kolumn w wierszu — stary szablon robil to skryptem,
     a uklad opiera sie na floatach, wiec bez tego kafelki „zaczepiaja sie” o siebie.
     Wiersze wyznaczamy deterministycznie z klas siatki Bootstrapa, nie z pomiaru. */
  function span(el) {
    var w = window.innerWidth;
    var order = w >= 1200 ? ['lg', 'md', 'sm', 'xs'] : w >= 992 ? ['md', 'sm', 'xs'] : w >= 768 ? ['sm', 'xs'] : ['xs'];
    var cls = ' ' + (el.className || '') + ' ';
    for (var i = 0; i < order.length; i++) {
      var m = cls.match(new RegExp('\\bcol-' + order[i] + '-(\\d+)\\b'));
      if (m) return parseInt(m[1], 10);
    }
    return 12;
  }

  function matchHeights() {
    var cols = [];
    document.querySelectorAll('.inner').forEach(function (el) {
      var p = el.parentElement;
      if (!p || !/\bcol-(xs|sm|md|lg)-\d+\b/.test(p.className || '')) return;
      el.style.height = '';
      cols.push({ inner: el, col: p, span: span(p) });
    });

    /* Kolejne kolumny w obrebie tej samej sekcji tworza wiersz, dopoki ich szerokosci
       miesza sie w 12 kolumnach siatki — tak jak robi to Bootstrap. Kolumny w jednym
       wierszu moga miec rozne szerokosci (np. naglowek: 2 + 6 + 4). */
    var rows = [], row = null, acc = 0, sec = null;
    cols.forEach(function (it) {
      var s = it.inner.closest('[class*="section"]') || document.body;
      var offset = (it.col.className.match(/\bcol-(?:xs|sm|md|lg)-offset-(\d+)\b/) || [0, 0])[1];
      var width = it.span + Number(offset);
      if (!row || s !== sec || acc + width > 12) {
        row = [];
        rows.push(row);
        acc = 0;
        sec = s;
      }
      row.push(it);
      acc += width;
    });

    rows.forEach(function (r) {
      if (r.length < 2) return;
      var max = 0;
      r.forEach(function (it) { max = Math.max(max, it.inner.getBoundingClientRect().height); });
      r.forEach(function (it) { it.inner.style.height = Math.round(max) + 'px'; });
    });
  }

  var mhTimer;
  function scheduleMatch() { clearTimeout(mhTimer); mhTimer = setTimeout(matchHeights, 60); }

  function boot() {
    initMenu();
    initButtons();
    initDropdownVisibility();
    document.querySelectorAll('.slider').forEach(initSlider);
    initCounters();
    initMarquee();
    initGallery();
    initTables();
    initSocial();
    initGoTop();
    matchHeights();
    window.addEventListener('load', scheduleMatch);
    window.addEventListener('resize', scheduleMatch);
    document.querySelectorAll('img').forEach(function (img) {
      if (!img.complete) img.addEventListener('load', scheduleMatch, { once: true });
    });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', boot);
  else boot();
})();
