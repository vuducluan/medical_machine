(function($) {
    "use strict";
    var $document = $(document),
        default_main_navigation = $('.site-header .main-navigation');
    CherryJsCore.utilites.namespace('theme_script');
    CherryJsCore.theme_script = {
        init: function() {
            if (CherryJsCore.status.is_ready) {
                this.document_ready_render();
            } else {
                CherryJsCore.variable.$document.on('ready', this.document_ready_render.bind(this));
            }
            if (CherryJsCore.status.on_load) {
                this.window_load_render();
            } else {
                CherryJsCore.variable.$window.on('load', this.window_load_render.bind(this));
            }
        },
        document_ready_render: function() {
            this.smart_slider_init(this);
            this.swiper_carousel_init(this);
            this.post_formats_custom_init(this);
            this.navbar_init(this);
            this.subscribe_init(this);
            this.main_menu(this, $('.site-header .main-navigation'));
            this.to_top_init(this);
            this.playlist_slider_widget_init(this);
            this.news_smart_box_init(this);
            this.header_search(this);
            this.mobile_menu(this);
            this.share_btns(this);
            this.shop_menu_drop(this);
        },
        window_load_render: function() {
            this.page_preloader_init(this);
        },
        smart_slider_init: function(self) {
            $('.tm-willard-smartslider').each(function() {
                var slider = $(this),
                    sliderId = slider.data('id'),
                    sliderWidth = slider.data('width'),
                    sliderHeight = slider.data('height'),
                    sliderOrientation = slider.data('orientation'),
                    slideDistance = slider.data('slide-distance'),
                    slideDuration = slider.data('slide-duration'),
                    sliderFade = slider.data('slide-fade'),
                    sliderNavigation = slider.data('navigation'),
                    sliderFadeNavigation = slider.data('fade-navigation'),
                    sliderPagination = slider.data('pagination'),
                    sliderAutoplay = slider.data('autoplay'),
                    sliderFullScreen = slider.data('fullscreen'),
                    sliderShuffle = slider.data('shuffle'),
                    sliderLoop = slider.data('loop'),
                    sliderThumbnailsArrows = slider.data('thumbnails-arrows'),
                    sliderThumbnailsPosition = slider.data('thumbnails-position'),
                    sliderThumbnailsWidth = slider.data('thumbnails-width'),
                    sliderThumbnailsHeight = slider.data('thumbnails-height');
                if ($('.smart-slider__items', '#' + sliderId).length > 0) {
                    $('#' + sliderId).sliderPro({
                        width: sliderWidth,
                        height: sliderHeight,
                        orientation: sliderOrientation,
                        slideDistance: slideDistance,
                        slideAnimationDuration: slideDuration,
                        fade: sliderFade,
                        arrows: sliderNavigation,
                        fadeArrows: sliderFadeNavigation,
                        buttons: sliderPagination,
                        autoplay: sliderAutoplay,
                        fullScreen: sliderFullScreen,
                        shuffle: sliderShuffle,
                        loop: sliderLoop,
                        waitForLayers: false,
                        thumbnailArrows: sliderThumbnailsArrows,
                        thumbnailsPosition: sliderThumbnailsPosition,
                        thumbnailWidth: sliderThumbnailsWidth,
                        thumbnailHeight: sliderThumbnailsHeight,
                        init: function() {
                            $(this).resize();
                        },
                        sliderResize: function(event) {
                            var thisSlider = $('#' + sliderId),
                                slides = $('.sp-slide', thisSlider);
                            slides.each(function() {
                                if ($('.sp-title a', this).width() > $(this).width()) {
                                    $(this).addClass('text-wrapped');
                                } else {
                                    $(this).removeClass('text-wrapped');
                                }
                            });
                        },
                        breakpoints: {
                            991: {
                                height: parseFloat(sliderHeight) * 0.75
                            },
                            767: {
                                height: parseFloat(sliderHeight) * 0.5,
                                thumbnailsPosition: ('top' === this.thumbnailsPosition) ? 'top' : 'bottom',
                                thumbnailHeight: parseFloat(sliderThumbnailsHeight) * 0.75,
                                thumbnailWidth: parseFloat(sliderThumbnailsWidth) * 0.75
                            }
                        }
                    });
                }
            });
        },
        swiper_carousel_init: function(self) {
            jQuery('.tm-willard-carousel').each(function() {
                var swiper = null,
                    uniqId = jQuery(this).data('uniq-id'),
                    slidesPerView = parseFloat(jQuery(this).data('slides-per-view')),
                    slidesPerViewXs = parseFloat(jQuery(this).data('slides-per-view-xs')),
                    slidesPerViewSm = parseFloat(jQuery(this).data('slides-per-view-sm')),
                    slidesPerViewMd = parseFloat(jQuery(this).data('slides-per-view-md')),
                    slidesPerViewLg = parseFloat(jQuery(this).data('slides-per-view-lg')),
                    slidesPerGroup = parseFloat(jQuery(this).data('slides-per-group')),
                    slidesPerColumn = parseFloat(jQuery(this).data('slides-per-column')),
                    spaceBetweenSlides = parseFloat(jQuery(this).data('space-between-slides')),
                    durationSpeed = parseFloat(jQuery(this).data('duration-speed')),
                    swiperLoop = jQuery(this).data('swiper-loop'),
                    freeMode = jQuery(this).data('free-mode'),
                    grabCursor = jQuery(this).data('grab-cursor'),
                    mouseWheel = jQuery(this).data('mouse-wheel'),
                    breakpointsSettings = {
                        1199: {
                            slidesPerView: Math.floor(slidesPerViewLg),
                            spaceBetween: Math.floor(spaceBetweenSlides)
                        },
                        991: {
                            slidesPerView: Math.floor(slidesPerViewMd),
                            spaceBetween: Math.floor(spaceBetweenSlides)
                        },
                        767: {
                            slidesPerView: Math.floor(slidesPerViewSm),
                            spaceBetween: Math.floor(spaceBetweenSlides)
                        },
                        479: {
                            slidesPerView: Math.floor(slidesPerViewXs),
                            spaceBetween: Math.floor(spaceBetweenSlides)
                        },
                    };
                if (1 == slidesPerView) {
                    breakpointsSettings = {}
                }
                var swiper = new Swiper('#' + uniqId, {
                    slidesPerView: slidesPerView,
                    slidesPerGroup: slidesPerGroup,
                    slidesPerColumn: slidesPerColumn,
                    spaceBetween: spaceBetweenSlides,
                    speed: durationSpeed,
                    loop: swiperLoop,
                    freeMode: freeMode,
                    grabCursor: grabCursor,
                    mousewheelControl: mouseWheel,
                    paginationClickable: true,
                    nextButton: '#' + uniqId + '-next',
                    prevButton: '#' + uniqId + '-prev',
                    pagination: '#' + uniqId + '-pagination',
                    onInit: function() {
                        $('#' + uniqId + '-next').css({
                            'display': 'block'
                        });
                        $('#' + uniqId + '-prev').css({
                            'display': 'block'
                        });
                    },
                    breakpoints: breakpointsSettings
                });
            });
        },
        post_formats_custom_init: function(self) {
            CherryJsCore.variable.$document.on('cherry-post-formats-custom-init', function(event) {
                if ('slider' !== event.object) {
                    return;
                }
                var uniqId = '#' + event.item.attr('id'),
                    swiper = new Swiper(uniqId, {
                        pagination: uniqId + ' .swiper-pagination',
                        paginationClickable: true,
                        nextButton: uniqId + ' .swiper-button-next',
                        prevButton: uniqId + ' .swiper-button-prev',
                        spaceBetween: 0,
                        onInit: function() {
                            $(uniqId + ' .swiper-button-next').css({
                                'display': 'block'
                            });
                            $(uniqId + ' .swiper-button-prev').css({
                                'display': 'block'
                            });
                        }
                    });
                event.item.data('initalized', true);
            });
            var items = [];
            $('.mini-gallery .post-thumbnail__link').on('click', function(event) {
                event.preventDefault();
                $(this).parents('.mini-gallery').find('.post-gallery__slides > a[href]').each(function() {
                    items.push({
                        src: $(this).attr('href'),
                        type: 'image'
                    });
                });
                $.magnificPopup.open({
                    items: items,
                    gallery: {
                        enabled: true
                    }
                });
            });
        },
        navbar_init: function(self) {
            $(window).load(function() {
                var $layout = tmWillard.labels.header_layout,
                    $navbar = ('minimal' === $layout || 'modern' === $layout) ? $('.vertical-toggle') : $('#main-menu');
                if (!$.isFunction(jQuery.fn.stickUp) || !$navbar.length) {
                    return !1;
                }
                $navbar.stickUp({
                    correctionSelector: '#wpadminbar',
                    listenSelector: '.listenSelector',
                    pseudo: true,
                    active: true
                });
                CherryJsCore.variable.$document.trigger('scroll.stickUp');
            });
        },
        subscribe_init: function(self) {
            CherryJsCore.variable.$document.on('click', '.subscribe-block__submit', function(event) {
                event.preventDefault();
                var $this = $(this),
                    form = $this.parents('form'),
                    nonce = form.find('input[name="nonce"]').val(),
                    mail_input = form.find('input[name="email"]'),
                    mail = mail_input.val(),
                    error = form.find('.subscribe-block__error'),
                    success = form.find('.subscribe-block__success'),
                    hidden = 'hidden';
                if ('' === mail) {
                    mail_input.addClass('error');
                    return !1;
                }
                if ($this.hasClass('processing')) {
                    return !1;
                }
                $this.addClass('processing');
                error.empty();
                mail_input.removeClass('error');
                if (!error.hasClass(hidden)) {
                    error.addClass(hidden);
                }
                if (!success.hasClass(hidden)) {
                    success.addClass(hidden);
                }
                $.ajax({
                    url: tmWillard.ajaxurl,
                    type: 'post',
                    dataType: 'json',
                    data: {
                        action: 'tmWillard_subscribe',
                        mail: mail,
                        nonce: nonce
                    },
                    error: function() {
                        $this.removeClass('processing');
                    }
                }).done(function(response) {
                    $this.removeClass('processing');
                    if (true === response.success) {
                        success.removeClass(hidden);
                        mail_input.val('');
                        return 1;
                    }
                    error.removeClass(hidden).html(response.data.message);
                    mail_input.addClass('error');
                    return !1;
                });
            });
        },
        main_menu: function(self, $mainNavigation) {
            var transitionend = 'transitionend oTransitionEnd webkitTransitionEnd',
                moreMenuContent = '&middot;&middot;&middot;',
                imgurl = '',
                srcset = '',
                hasimg = false,
                hasicon = false,
                hasprop = Object.prototype.hasOwnProperty,
                liWithChildren = 'li.menu-item-has-children, li.page_item_has_children',
                $body = $('body'),
                $parentNode, menuItem, subMenu, index = -1;
            if (hasprop.call(window, 'tmWillard') && hasprop.call(window.tmWillard, 'more_button_options') && hasprop.call(window.tmWillard.more_button_options, 'more_button_type')) {
                switch (window.tmWillard.more_button_options.more_button_type) {
                    case 'image':
                        imgurl = window.tmWillard.more_button_options.more_button_image_url;
                        if (window.tmWillard.more_button_options.retina_more_button_image_url) {
                            srcset = ' srcset="' + window.tmWillard.more_button_options.retina_more_button_image_url + ' 2x"';
                        }
                        moreMenuContent = '<img src="' + imgurl + '"' + srcset + ' alt="' + moreMenuContent + '">';
                        hasimg = true;
                        break;
                    case 'icon':
                        moreMenuContent = '<i class="fa ' + window.tmWillard.more_button_options.more_button_icon + '"></i>';
                        hasicon = true;
                        break;
                    case 'text':
                    default:
                        moreMenuContent = window.tmWillard.more_button_options.more_button_text || moreMenuContent;
                        hasimg = false;
                        hasicon = false;
                        break;
                }
            }
            $mainNavigation.superGuacamole({
                threshold: 768,
                minChildren: 3,
                childrenFilter: '.menu-item',
                menuTitle: moreMenuContent,
                menuUrl: '#',
                templates: {
                    menu: '<li id="%5$s" class="%1$s' + (hasimg ? ' super-guacamole__menu-with-image' : '') +
                        (hasicon ? ' super-guacamole__menu-with-icon' : '') + '"><a href="%2$s">%3$s</a><ul class="sub-menu">%4$s</ul></li>',
                    child_wrap: '<ul class="%1$s">%2$s</ul>',
                    child: '<li id="%5$s" class="%1$s"><a href="%2$s">%3$s</a><ul class="sub-menu">%4$s</ul></li>'
                }
            });

            function hideSubMenu(menuItem) {
                subMenu = menuItem.children('.sub-menu');
                menuItem.removeData('index').removeClass('menu-hover');
            }

            function handleMenuItemHover($event) {
                menuItem = $($event.target).parents('.menu-item');
                subMenu = menuItem.children('.sub-menu').first();
                if (!menuItem.hasClass('menu-item-has-children')) {
                    menuItem = $event.target.tagName === 'LI' ? $($event.target) : $($event.target).parents().filter('.menu-item');
                }
                switch ($event.type) {
                    case 'mouseenter':
                    case 'mouseover':
                        menuItem.addClass('menu-hover');
                        if (0 < subMenu.length) {
                            var maxWidth = $body.outerWidth(true),
                                subMenuOffset = subMenu.offset().left + subMenu.outerWidth(true);
                            if (maxWidth <= subMenuOffset) {
                                subMenu.addClass('left-side');
                                subMenu.find('.sub-menu').addClass('left-side');
                            } else if (0 > subMenu.offset().left) {
                                subMenu.removeClass('left-side');
                                subMenu.find('.sub-menu').removeClass('left-side');
                            }
                        }
                        break;
                    case 'mouseleave':
                        hideSubMenu(menuItem);
                        break;
                }
            }
            CherryJsCore.variable.$window.on('orientationchange resize', function() {
                $mainNavigation.find('.menu-item').removeClass('menu-hover');
                $mainNavigation.find('.sub-menu.left-side').removeClass('left-side');
                $mainNavigation.find('.sub-menu.animate').removeClass('animate');
            });
            $mainNavigation.on('mouseenter mouseover mouseleave', '.menu-item', handleMenuItemHover);
            $('#vertical_menu .main-navigation').on('mouseenter mouseover mouseleave', '.menu-item', handleMenuItemHover);
            $mainNavigation.on('mouseover', '.menu-item', function($event) {
                $($event.target).parents('.menu-item').children('.sub-menu').first().addClass('animate');
            });

            function doubleClickMenu($jqEvent) {
                var menuIndex = $(this).index();
                $parentNode = $(this);
                if (menuIndex !== parseInt($parentNode.data('index'), 10)) {
                    $jqEvent.preventDefault();
                }
                $parentNode.data('index', menuIndex);
            }
            if ('ontouchend' in window) {
                $(liWithChildren, $mainNavigation).on('click', doubleClickMenu);
                CherryJsCore.variable.$document.on('touchend', function($jqEvent) {
                    $parentNode = $($jqEvent.target).parents().filter('.menu-item');
                    if ($parentNode.hasClass('menu-hover') === false) {
                        hideSubMenu($parentNode);
                        index = $parentNode.data('index');
                        if (index) {
                            $parentNode.data('index', parseInt(index, 10) - 1);
                        }
                    }
                });
            }
        },
        mobile_menu: function(self) {
            var $mainNavigation = $('.main-navigation'),
                $menuToggle = $('.mobile-toggle[aria-controls="main-menu"]');
            $menuToggle.on('click', function($event) {
                $event.preventDefault();
                setTimeout(function() {
                    if (!$mainNavigation.hasClass('animate')) {
                        $mainNavigation.addClass('animate');
                    }
                    $mainNavigation.toggleClass('show');
                    $('html').toggleClass('mobile-menu-active');
                }, 10);
                $menuToggle.attr('aria-expanded', !$menuToggle.hasClass('toggled'));
                $menuToggle.toggleClass('toggled');
            });
            $mainNavigation.find('li.menu-item-has-children > a').after('<span class="sub-menu-toggle"></span>');

            function debounce(threshold, callback) {
                var timeout;
                return function debounced($event) {
                    function delayed() {
                        callback($event);
                        timeout = null;
                    }
                    if (timeout) {
                        clearTimeout(timeout);
                    }
                    timeout = setTimeout(delayed, threshold);
                };
            }

            function resizeHandler($event) {
                var $window = CherryJsCore.variable.$window,
                    width = $window.outerWidth(true);
                if (768 <= width) {
                    $mainNavigation.removeClass('mobile-menu');
                } else {
                    $mainNavigation.addClass('mobile-menu');
                }
            }

            function toggleSubMenuHandler($event) {
                var $subMenu = $(this);
                $subMenu.toggleClass('active');
                $subMenu.parent().toggleClass('sub-menu-open');
            }

            function toggleMenuHandler($event) {
                var $toggle = $(this),
                    $window = CherryJsCore.variable.$window,
                    width = $window.outerWidth(true);
                $event.preventDefault();
                $mainNavigation.toggleClass('active');
                if ($toggle.hasClass('active')) {
                    $toggle.removeClass('active');
                    $mainNavigation.find('.sub-menu-open').removeClass('sub-menu-open');
                }
            }
            resizeHandler();
            CherryJsCore.variable.$window.on('resize orientationchange', debounce(500, resizeHandler));
            $mainNavigation.on('click', '.mega-menu-mobile-arrow', toggleSubMenuHandler);
            $mainNavigation.on('click', '.sub-menu-toggle', toggleSubMenuHandler);
            $menuToggle.on('click', toggleMenuHandler);
        },
        page_preloader_init: function(self) {
            if ($('.page-preloader-cover')[0]) {
                $('.page-preloader-cover').delay(500).fadeTo(500, 0, function() {
                    $(this).remove();
                });
            }
        },
        to_top_init: function(self) {
            if ($.isFunction(jQuery.fn.UItoTop)) {
                $().UItoTop({
                    text: tmWillard.labels.totop_button,
                    scrollSpeed: 600
                });
            }
        },
        playlist_slider_widget_init: function(self) {
            $('.widget-playlist-slider .playlist-slider').each(function() {
                var $this = $(this),
                    settings = $this.data('settings'),
                    breakpoints = JSON.parse(settings.breakpoints);
                $this.sliderPro({
                    autoplay: false,
                    width: settings['width'],
                    height: parseInt(settings['height']),
                    orientation: 'vertical',
                    waitForLayers: false,
                    touchSwipe: false,
                    updateHash: false,
                    arrows: settings['arrows'],
                    buttons: settings['buttons'],
                    thumbnailArrows: settings['thumbnailArrows'],
                    thumbnailsPosition: settings['thumbnailsPosition'],
                    thumbnailPointer: true,
                    thumbnailWidth: settings['thumbnailWidth'],
                    thumbnailHeight: settings['thumbnailHeight'],
                    breakpoints: breakpoints,
                    init: function() {
                        $this.resize().fadeTo(0, 1);
                    },
                    gotoSlideComplete: function(event) {
                        var prevSlide = $('.sp-slide', $this).eq(event.previousIndex),
                            iframe = prevSlide.find('iframe'),
                            html5Video = prevSlide.find('video');
                        if (iframe[0]) {
                            var iframeSrc = iframe.attr('src');
                            iframe.attr('src', iframeSrc);
                        } else if (html5Video[0]) {
                            html5Video[0].stop();
                        }
                    }
                });
            });
        },
        news_smart_box_init: function(self) {
            jQuery('.news-smart-box__instance').each(function() {
                var uniqId = $(this).data('uniq-id'),
                    instanceSettings = $(this).data('instance-settings'),
                    instance = $('#' + uniqId),
                    $termItem = $('.news-smart-box__navigation-terms-list-item', instance),
                    $currentTerm = $('.news-smart-box__navigation-title', instance),
                    $listContainer = $('.news-smart-box__wrapper', instance),
                    $ajaxPreloader = $('.nsb-spinner', instance),
                    $termsList = $('.news-smart-box__navigation-terms-list', instance),
                    $menuToggle = $('.menu-toggle', instance),
                    ajaxGetNewInstance = null,
                    ajaxGetNewInstanceSuccess = true,
                    showNewItems = null;
                $termItem.each(function() {
                    var slug = $(this).data('slug');
                    if ('category' === instanceSettings.terms_type) {
                        if (slug === instanceSettings.current_category) {
                            $(this).addClass('is-active');
                        }
                    } else {
                        if (slug === instanceSettings.current_tag) {
                            $(this).addClass('is-active');
                        }
                    }
                });
                $menuToggle.on('click', function($jqEvent) {
                    $jqEvent.preventDefault();
                    $menuToggle.toggleClass('news-smart-box__navigation-toggle--open');
                    $termsList.toggleClass('news-smart-box__navigation-terms-list--open');
                });
                $termItem.on('click', function() {
                    var slug = $(this).data('slug'),
                        data = {
                            action: 'new_smart_box_instance',
                            value_slug: slug,
                            instance_settings: instanceSettings
                        },
                        currentTermName = $(this).text(),
                        counter = 0;
                    if (!$(this).hasClass('is-active')) {
                        $termItem.removeClass('is-active');
                        $(this).addClass('is-active');
                    }
                    $currentTerm.html(currentTermName);
                    if (ajaxGetNewInstance !== null) {
                        ajaxGetNewInstance.abort();
                    }
                    ajaxGetNewInstance = $.ajax({
                        type: 'GET',
                        url: tmWillard.ajaxurl,
                        data: data,
                        cache: false,
                        beforeSend: function() {
                            ajaxGetNewInstanceSuccess = false;
                            $ajaxPreloader.css({
                                'display': 'block'
                            }).fadeTo(300, 1);
                        },
                        success: function(response) {
                            ajaxGetNewInstanceSuccess = true;
                            $ajaxPreloader.fadeTo(300, 0, function() {
                                $(this).css({
                                    'display': 'none'
                                });
                            });
                            $('.news-smart-box__listing', $listContainer).html(response);
                            counter = 0;
                            $('.news-smart-box__item-inner', $listContainer).addClass('animate-cycle-show');
                            $('.news-smart-box__item', $listContainer).each(function() {
                                showItem($(this), 100 * parseInt(counter) + 200);
                                counter++;
                            })
                        }
                    });
                });
                var showItem = function(itemList, delay) {
                    var timeOutInterval = setTimeout(function() {
                        $('.news-smart-box__item-inner', itemList).removeClass('animate-cycle-show');
                    }, delay);
                }
            });
        },
        header_search: function(self) {
            var $header = $('.site-header'),
                $searchToggle = $('.search-form__toggle, .search-form__close', $header),
                $headerSearch = $('.header-search', $header),
                $searchInput = $('.search-form__field', $headerSearch),
                searchHandler = function(event) {
                    $header.toggleClass('search-active');
                    if ($header.hasClass('search-active')) {
                        $searchInput.focus();
                    }
                },
                removeActiveClass = function(event) {
                    if ($(event.target).closest($searchToggle).length || $(event.target).closest($headerSearch).length) {
                        return;
                    }
                    if ($header.hasClass('search-active')) {
                        $header.removeClass('search-active');
                    }
                    event.stopPropagation();
                };
            $searchToggle.on('click', searchHandler);
            CherryJsCore.variable.$document.on('click', removeActiveClass);
        },
        share_btns: function(self) {
            $('.icon-toggle-share-btns').on('click', function() {
                $(this).parents('.share-btns__list-wrap').toggleClass('open');
            });
            $(document).on('click', function(e) {
                var target = e.target;
                if (!$(target).is('.icon-toggle-share-btns') && !$(target).parents().is('.share-btns__list')) {
                    $('.share-btns__list-wrap').removeClass('open');
                }
            });
        },
        shop_menu_drop: function(self) {
            $('.icon-drodown').on('click', function() {
                $(this).parents('.dropdown-wrap__block').toggleClass('opened');
            });
            $(document).on('click', function(e) {
                var target = e.target;
                if (!$(target).is('.icon-drodown') && !$(target).parents().is('.top-panel__menu')) {
                    $('.dropdown-wrap__block').removeClass('opened');
                }
            });
        }
    };
    CherryJsCore.theme_script.init();

    function stopPropagation(event) {
        event.stopPropagation();
    }
    var topPanelWrapBlock = document.querySelector('.top-panel__menu-wrap'),
        topPanelMenuListUL = document.querySelector('.top-panel__menu-list'),
        verticalMenuWrapBlock = document.querySelector('#vertical_menu'),
        verticalInner = document.querySelector('#vertical_menu  .header-main-menu'),
        headerDefault = document.querySelector('.home .default .header-container');
    var windWidth = window.innerWidth;
    window.onresize = function() {
        var windWidthRes = window.innerWidth;
        if (topPanelMenuListUL) {
            if (topPanelMenuListUL.children.length > 2 && windWidthRes < 1400) {
                topPanelWrapBlock.classList.add('dropdown');
            } else if (topPanelMenuListUL.children.length > 2 && windWidthRes > 1400) {
                topPanelWrapBlock.classList.remove('dropdown');
            }
        }
        if (windWidthRes < 992 && headerDefault) {
            headerDefault;
        } else if (verticalMenuWrapBlock && windWidthRes > 992 && headerDefault) {
            verticalMenuWrapBlock;
        }
    };
    if (windWidth < 992 && headerDefault) {
        headerDefault;
    }
    if (topPanelMenuListUL) {
        if ((topPanelMenuListUL.children.length > 2 && windWidth < 1400) || topPanelMenuListUL.children.length > 4) {
            topPanelWrapBlock.classList.add('dropdown');
        } else if ((topPanelMenuListUL.children.length < 2 && windWidth > 1400) || topPanelMenuListUL.children.length < 4) {
            topPanelWrapBlock.classList.remove('dropdown');
        }
    }
}(jQuery));
