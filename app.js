// ResumeRank Landing Page Controller & Navigation Router
document.addEventListener('DOMContentLoaded', () => {

  // Mobile Menu Toggle
  const mobileToggle = document.getElementById('mobileToggle');
  const navMenu = document.getElementById('navMenu');

  if (mobileToggle && navMenu) {
    mobileToggle.addEventListener('click', () => {
      navMenu.classList.toggle('active');
    });
  }

  // Smooth Scroll for In-Page Section Anchor Links
  const navLinks = document.querySelectorAll('a[href^="#"]');
  navLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      const targetId = link.getAttribute('href');
      if (targetId && targetId !== '#') {
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
          e.preventDefault();
          
          // Update active link styling
          document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
          if (link.classList.contains('nav-link')) {
            link.classList.add('active');
          }

          // Close mobile menu if open
          if (navMenu && navMenu.classList.contains('active')) {
            navMenu.classList.remove('active');
          }

          // Smooth Scroll
          targetElement.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      }
    });
  });

  // Highlight Nav Link on Scroll
  const sections = document.querySelectorAll('section[id], main[id], footer[id]');
  window.addEventListener('scroll', () => {
    let currentSectionId = '';
    const scrollPosition = window.scrollY + 200;

    sections.forEach(section => {
      if (section.offsetTop <= scrollPosition) {
        currentSectionId = section.getAttribute('id');
      }
    });

    if (currentSectionId) {
      document.querySelectorAll('.nav-link').forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === `#${currentSectionId}`) {
          link.classList.add('active');
        }
      });
    }
  });

  // Product Preview Card Progress Fill Animation
  const previewCard = document.querySelector('.product-preview-card');
  const progressFills = document.querySelectorAll('.progress-bar-fill');

  if (previewCard && progressFills.length > 0) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          progressFills.forEach(fill => {
            const targetWidth = fill.style.width;
            fill.style.width = '0%';
            setTimeout(() => {
              fill.style.width = targetWidth;
            }, 100);
          });
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.2 });

    observer.observe(previewCard);
  }

});
