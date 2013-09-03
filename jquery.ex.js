// Generated by CoffeeScript 1.6.2
(function() {
  var $;

  $ = jQuery;

  if (window.ko) {
    ko.bindingHandlers.youtube = {
      update: function(element, valueAccessor) {
        var id;

        id = ko.utils.unwrapObservable(valueAccessor());
        return $(element).youtube({
          id: id
        });
      }
    };
    ko.bindingHandlers.facebook_like = {
      update: function(element, valueAccessor) {
        var fb;

        fb = ko.utils.unwrapObservable(valueAccessor());
        return $(element).facebook_like(fb);
      }
    };
  }

  $.YouTube = (function() {
    YouTube.prototype._page = "https://www.youtube.com";

    function YouTube(id) {
      this.id = id;
      this.url = "" + this._page + "/watch?" + ($.param({
        v: this.id
      }));
      this.thumbnail = "https://img.youtube.com/vi/" + this.id + "/0.jpg";
      this.embed = "" + this._page + "/embed/" + this.id;
    }

    return YouTube;

  })();

  $.fn.youtube = function(_arg) {
    var id, yt;

    id = _arg.id;
    yt = new $.YouTube(id);
    return this.empty().append($('<iframe>').attr('src', yt.embed).css('width', '100%').css('height', '100%'));
  };

  $.fn.facebook_like = function(_arg) {
    var href, send, show_faces;

    href = _arg.href, show_faces = _arg.show_faces, send = _arg.send;
    if (send == null) {
      send = false;
    }
    if (show_faces == null) {
      show_faces = false;
    }
    return this.each(function() {
      var _ref;

      $(this).empty().append($('<div>').addClass('fb-like').attr('data-show-faces', show_faces).attr('data-send', send).attr('data-href', href));
      return (_ref = window.FB) != null ? _ref.XFBML.parse(this) : void 0;
    });
  };

  $.fn.formify = function() {
    return this.click(function() {
      var data, form;

      data = $(this).data();
      if (data.confirm) {
        if (!confirm(data.confirm)) {
          return false;
        }
      }
      form = $('<form>').attr('method', 'post').attr('action', this.href);
      form.submit();
      return false;
    });
  };

  $.fn.confirmify = function() {
    var handler;

    handler = function() {
      if (confirm($(this).data().confirm)) {
        return true;
      }
      return false;
    };
    return this.each(function() {
      if ($(this).is('form')) {
        return $(this).submit(handler);
      } else {
        return $(this).click(handler);
      }
    });
  };

  $(function() {
    var _base;

    $('.formify').formify();
    $('.confirmify').confirmify();
    if (typeof (_base = $('.fb-share')).popupWindow === "function") {
      _base.popupWindow({
        width: 626,
        height: 346,
        centerBrowser: 1
      });
    }
    return $('.focused').select();
  });

}).call(this);
