(function($) {

    var DropzoneRailsManager = Class.extend({
        
        // variables
        handlers: [],
        
        init: function(options) {
            var self = this;
            this.handlers = [];
            $(".dropzone-ui").each(function() {
              self.handlers.push(new DropzoneRails.Handler($(this), options));
            });
        }
        
    }); 
    
    // register namespace
    $.extend(true, window, {
        "DropzoneRails": {
            "Manager": DropzoneRailsManager
        }
    });
    
})(jQuery);
