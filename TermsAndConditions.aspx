<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TermsAndConditions.aspx.cs" Inherits="FEMHS_Code_Co_Falcon.WebForm6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    

<section class="tc-hero">
    <div class="tc-hero__inner">
        <h1>Terms and Conditions</h1>
        <nav class="tc-breadcrumb" aria-label="Breadcrumb">
            <a href="Home.aspx">Home</a>
            <span aria-hidden="true">/</span>
            <span aria-current="page">Terms and Conditions</span>
        </nav>
    </div>
</section>

<div class="tc-container">

    <aside class="tc-sidebar">
        <div class="tc-sidebar__card">
            <h5>On this page</h5>

            <ol class="tc-toc">
                <li>
                    <a href="#introduction" class="tc-toc__link">Introduction</a>
                </li>

                <li class="tc-toc__parent-item">
                    <button type="button" class="tc-toc__link tc-toc__link--parent" aria-expanded="false">
                        <span class="tc-toc__label">Company Policy</span>
                        <span class="tc-toc__arrow" aria-hidden="true"></span>
                    </button>
                    <ul class="tc-toc__sublist">
                        <li><a href="#our-responsibilities" target="_self">Our Responsibilities</a></li>
                        <li><a href="#your-responsibilities" target="_self">Your Responsibilities</a></li>
                    </ul>
                </li>

                <li>
                    <a href="#privacy-policy" target="_self" class="tc-toc__link">Privacy Policy</a>
                </li>

                <li>
                    <a href="#cookie-policy" target="_self" class="tc-toc__link">Cookie Policy</a>
                </li>

                <li>
                    <a href="#returns-and-refunds" target="_self" class="tc-toc__link">Returns And Refunds</a>
                </li>

                <li>
                    <a href="#booking-policy" target="_self" class="tc-toc__link">Booking Policy</a>
                </li>

                <li>
                    <a href="#payment-and-pricing-policy" target="_self" class="tc-toc__link">Payment And Pricing Policy</a>
                </li>

                <li>
                    <a href="#delivery-and-collection" target="_self" class="tc-toc__link">Delivery And Collection</a>
                </li>

                <li class="tc-toc__parent-item">
                    <button type="button" class="tc-toc__link tc-toc__link--parent" aria-expanded="false">
                        <span class="tc-toc__label">Damage And Liability</span>
                        <span class="tc-toc__arrow" aria-hidden="true"></span>
                    </button>
                    <ul class="tc-toc__sublist">
                        <li><a href="#damage-and-loss" target="_self">Damage &amp; Loss</a></li>
                        <li><a href="#limitation-of-liability" target="_self">Limitation of liability</a></li>
                    </ul>
                </li>

                <li>
                    <a href="#governing-law" target="_self" class="tc-toc__link">Governing Law</a>
                </li>
            </ol>
        </div>

        <div class="tc-help-card">
            <span class="tc-help-card__icon" aria-hidden="true">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 18v-6a9 9 0 0 1 18 0v6"></path>
                    <path d="M21 19a2 2 0 0 1-2 2h-1a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h3zM3 19a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H3z"></path>
                </svg>
            </span>
            <h5>Need help?</h5>
            <p>If you have any questions, feel free to contact our support team.</p>
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="tc-help-card__btn">
                Contact Us
                <span aria-hidden="true">&#8594;</span>
            </asp:LinkButton>
        </div>
    </aside>

    <div class="tc-content">
        <p class="tc-updated">Last updated: 26 May 2025</p>
        <p>Please read these Terms and Conditions carefully before using our website or hiring our equipment and services.</p>

        <section class="tc-section" id="introduction">
            <h2>1. Introduction</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="company-policy">
            <h2>2. Company Policy</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>

            <h3 id="our-responsibilities">Our Responsibilities</h3>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>

            <h3 id="your-responsibilities">Your Responsibilities</h3>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="privacy-policy">
            <h2>3. Privacy Policy</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="cookie-policy">
            <h2>4. Cookie Policy</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="returns-and-refunds">
            <h2>5. Returns And Refunds</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="booking-policy">
            <h2>6. Booking Policy</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="payment-and-pricing-policy">
            <h2>7. Payment And Pricing Policy</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="delivery-and-collection">
            <h2>8. Delivery And Collection</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="damage-and-liability">
            <h2>9. Damage And Liability</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>

            <h3 id="damage-and-loss">Damage &amp; Loss</h3>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>

            <h3 id="limitation-of-liability">Limitation of liability</h3>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
        <hr />

        <section class="tc-section" id="governing-law">
            <h2>10. Governing Law</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum</p>
        </section>
    </div>

</div>

<style>
    :root {
        --tc-navy: #142c6b;
        --tc-navy-dark: #0f2255;
        --tc-blue-link: #1a4fa3;
        --tc-blue-tint: #eef3fc;
        --tc-border: #e5e8ee;
        --tc-text: #333c4d;
        --tc-text-muted: #6b7280;
    }

    * { box-sizing: border-box; }

    .tc-hero {
        padding: 32px 0 8px;
        font-family: -apple-system, "Segoe UI", Arial, sans-serif;
    }

    .tc-hero__inner {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .tc-hero__inner h1 {
        margin: 0 0 8px;
        color: var(--tc-navy);
        font-size: 28px;
        font-weight: 700;
    }

    .tc-breadcrumb {
        font-size: 13px;
        color: var(--tc-text-muted);
    }

    .tc-breadcrumb a {
        color: var(--tc-blue-link);
        text-decoration: none;
    }

    .tc-breadcrumb a:hover { text-decoration: underline; }

    .tc-breadcrumb span[aria-hidden] { margin: 0 6px; }

    .tc-container {
        display: flex;
        align-items: flex-start;
        gap: 32px;
        max-width: 1200px;
        margin: 0 auto;
        padding: 16px 24px 64px;
        font-family: -apple-system, "Segoe UI", Arial, sans-serif;
        color: var(--tc-text);
    }

    /* -------------------- Sidebar -------------------- */
    .tc-sidebar {
        width: 260px;
        flex-shrink: 0;
        position: sticky;
        top: 20px; /* gap between sidebar and top of viewport while scrolling */
        align-self: flex-start; /* needed alongside align-items: flex-start on the flex parent for sticky to work */
    }

    .tc-sidebar__card {
        border: 1px solid var(--tc-border);
        border-radius: 8px;
        overflow: hidden;
        margin-bottom: 20px;
    }

    .tc-sidebar__card h5 {
        margin: 0;
        padding: 16px 18px;
        font-size: 14px;
        font-weight: 700;
        border-bottom: 1px solid var(--tc-border);
    }

    .tc-toc {
        list-style: none;
        counter-reset: tc-counter;
        margin: 0;
        padding: 8px 0;
    }

    /* Only top-level items get a number, matching the screenshot */
    .tc-toc > li {
        counter-increment: tc-counter;
    }

    .tc-toc__link {
        display: block;
        padding: 8px 18px;
        font-size: 13px;
        color: var(--tc-blue-link);
        text-decoration: none;
        border-left: 3px solid transparent;
    }

    /* Numbering only ever applies to the plain <a> links. The two
       dropdown buttons get their number from the inner label span
       instead (see .tc-toc__label::before below) — keeping these two
       rules mutually exclusive by tag name avoids the double-numbering
       and layout-shifting bug from before. */
    .tc-toc > li > a.tc-toc__link::before {
        content: counter(tc-counter) ". ";
    }

    .tc-toc__label::before {
        content: counter(tc-counter) ". ";
    }

    .tc-toc__link:hover {
        background: #f7f9fc;
    }

    /* Currently active page/section */
    .tc-toc__link.is-active {
        background: var(--tc-blue-tint);
        border-left-color: var(--tc-navy);
        color: var(--tc-navy);
        font-weight: 600;
    }

    /* Parent items (Company Policy / Damage And Liability) are buttons
       that toggle their sub-list open/closed — styled the same as the
       other plain links, just with an arrow */
    .tc-toc__link--parent {
        width: 100%;
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-family: inherit;
        font-weight: 400;
        font-size: 13px;
        line-height: inherit;
        color: var(--tc-blue-link);
        background: none;
        border: none;
        border-left: 3px solid transparent; /* matches .tc-toc__link so the text doesn't shift */
        border-radius: 0;
        -webkit-appearance: none;
        appearance: none;
        text-align: left;
        cursor: pointer;
    }

    .tc-toc__arrow {
        width: 7px;
        height: 7px;
        border-right: 2px solid #888;
        border-bottom: 2px solid #888;
        transform: rotate(45deg);
        transition: transform 0.15s ease-in-out;
        flex-shrink: 0;
        margin-left: 8px;
    }

    /* Arrow points up when expanded */
    .tc-toc__parent-item.is-expanded .tc-toc__arrow {
        transform: rotate(-135deg);
    }

    /* Highlight the parent row while its section is open */
    .tc-toc__parent-item.is-expanded > .tc-toc__link--parent {
        background: var(--tc-blue-tint);
    }

    .tc-toc__sublist {
        list-style: none;
        margin: 0;
        padding: 0;
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.2s ease-in-out;
    }

    .tc-toc__parent-item.is-expanded > .tc-toc__sublist {
        max-height: 200px;
        padding-bottom: 4px;
    }

    .tc-toc__sublist a {
        display: block;
        padding: 6px 18px 6px 32px;
        font-size: 13px;
        color: var(--tc-blue-link);
        text-decoration: none;
    }

    .tc-toc__sublist a:hover {
        background: #f7f9fc;
    }

    .tc-toc__sublist a.is-active {
        background: var(--tc-blue-tint);
        color: var(--tc-navy);
        font-weight: 600;
    }

    /* -------------------- Need Help card -------------------- */
    .tc-help-card {
        border: 1px solid var(--tc-border);
        background: #f8fafd;
        border-radius: 8px;
        padding: 20px 18px;
        text-align: left;
    }

    .tc-help-card__icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 34px;
        height: 34px;
        border-radius: 50%;
        background: var(--tc-blue-tint);
        color: var(--tc-navy);
        margin-bottom: 10px;
    }

    .tc-help-card h5 {
        margin: 0 0 6px;
        font-size: 15px;
        font-weight: 700;
        color: #1a1a1a;
    }

    .tc-help-card p {
        margin: 0 0 14px;
        font-size: 13px;
        color: var(--tc-text-muted);
        line-height: 1.5;
    }

    .tc-help-card__btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 16px;
        background: #fff;
        border: 1px solid var(--tc-navy);
        color: var(--tc-navy);
        border-radius: 6px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
    }

    .tc-help-card__btn:hover {
        background: var(--tc-blue-tint);
    }

    /* -------------------- Main content column -------------------- */
    .tc-content {
        flex: 1;
        min-width: 0;
        font-size: 14px;
        line-height: 1.6;
    }

    .tc-updated {
        color: var(--tc-text-muted);
        font-size: 13px;
        margin: 0 0 8px;
    }

    .tc-section {
        scroll-margin-top: 20px;
    }

    .tc-section h3 {
        scroll-margin-top: 20px;
    }

    .tc-section h2 {
        color: var(--tc-navy);
        font-size: 18px;
        font-weight: 700;
        margin: 28px 0 10px;
    }

    .tc-section h3 {
        color: var(--tc-navy);
        font-size: 15px;
        font-weight: 600;
        margin: 16px 0 6px;
    }

    .tc-section p {
        font-size: 14px;
        line-height: 1.6;
        margin: 0 0 4px;
    }

    .tc-content hr {
        border: none;
        border-top: 1px solid var(--tc-border);
        margin: 18px 0 0;
    }

    /* -------------------- Responsive -------------------- */
    @media (max-width: 860px) {
        .tc-container {
            flex-direction: column;
            padding: 24px 20px 48px;
        }

        .tc-sidebar {
            width: 100%;
            position: static;
        }
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var toc = document.querySelector('.tc-toc');
        if (!toc) return;

        var links = Array.prototype.slice.call(toc.querySelectorAll('a[href^="#"]'));

        function setActive(id) {
            links.forEach(function (link) {
                link.classList.toggle('is-active', link.getAttribute('href') === '#' + id);
            });
        }

        function openDropdown(item) {
            if (!item || item.classList.contains('is-expanded')) return;
            item.classList.add('is-expanded');
            var btn = item.querySelector('.tc-toc__link--parent');
            if (btn) btn.setAttribute('aria-expanded', 'true');
        }

        function closeDropdown(item) {
            item.classList.remove('is-expanded');
            var btn = item.querySelector('.tc-toc__link--parent');
            if (btn) btn.setAttribute('aria-expanded', 'false');
        }

        // Single delegated listener on the whole list — handles both the
        // dropdown toggle buttons and the plain/nested anchor links, so
        // there's one clear place this logic lives instead of several
        // separate listeners that can silently miss elements.
        toc.addEventListener('click', function (e) {
            var toggleBtn = e.target.closest('.tc-toc__link--parent');
            if (toggleBtn) {
                var item = toggleBtn.closest('.tc-toc__parent-item');
                if (item.classList.contains('is-expanded')) {
                    closeDropdown(item);
                } else {
                    openDropdown(item);
                }
                return;
            }

            var link = e.target.closest('a[href^="#"]');
            if (!link) return;

            e.preventDefault();
            var target = document.querySelector(link.getAttribute('href'));
            if (!target) return;

            var parentItem = link.closest('.tc-toc__parent-item');
            if (parentItem) openDropdown(parentItem);

            target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            setActive(link.getAttribute('href').slice(1));
        });

        // Highlight whichever section is currently scrolled into view
        var sections = links
            .map(function (link) { return document.querySelector(link.getAttribute('href')); })
            .filter(Boolean);

        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    setActive(entry.target.id);
                }
            });
        }, { rootMargin: '-20% 0px -70% 0px' }); // fires when a section nears the top of the viewport

        sections.forEach(function (section) { observer.observe(section); });
    });
</script>



</asp:Content>
