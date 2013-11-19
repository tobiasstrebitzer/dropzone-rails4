(function($) {

    var DropzoneRailsHandler = Class.extend({
        
        defaults: {
            allowed_sizes: [],
            allowed_types: ["image/png","image/jpeg","image/gif"],
            max_files: 1,
            width: null,
            multiple: false,
            onSuccess: function(file, response) {}
        },
        url: null,
        options: null,
        entityId: null,
        images: [],
        
        // variables
        dropzone: null,
        totalFiles: 0,
        
        // ui
        $fileManager: null,
        $dropzone: null,
        
        init: function($fileManager, options) {
            var self = this;
            
            self.$fileManager = $fileManager;
            self.url = self.$fileManager.data("url");

            // Load profile information
            $.ajax({
                url: self.url,
                type: "GET",
                success: function(response) {
                    
                    // Save options
                    self.options = $.extend(true, {}, self.defaults, options, response.profile);
                    
                    // Store entity
                    self.entityId = response.entity_id;
                    
                    // Create images
                    self.images = response.images;
            
                    // initialize widget
                    self.initializeWidget();
                    self.initializeDropzone();
            
                    // set total files
                    self.totalFiles = self.images.length;
                    
                }
            });                    
            
        },
        
        initializeWidget: function() {
            
            // cleanup
            this.$fileManager.html();
            
            // add dropzone
            this.$dropzone = $("<div class='filemanager-container dropzone'></div>").appendTo(this.$fileManager);
            
            if(this.options.width) {
                this.$dropzone.width(this.options.width);
            }
            
        },
        
        initializeDropzone: function() {
            var self = this;
            
            // Initialize dropzone
            this.dropzone = new Dropzone(this.$dropzone[0], { 
                url: this.url,
                thumbnailWidth: 148,
                thumbnailHeight: 148,
                uploadMultiple: false,
                paramName: "image",
                params: {},
                addRemoveLinks: true,
                dictCancelUpload: "Cancel",
                dictRemoveFile: "Delete",
                acceptedFiles: this.options.allowed_types ? this.options.allowed_types.join(",") : "",
                acceptedSizes: this.options.allowed_sizes
            });
            
            // Add existing items
            for (var i = 0; i < this.images.length; i++) {
                this.dropzone.emit("addedfile", this.images[i]);
                this.dropzone.emit("thumbnail", this.images[i], this.images[i].src);
            }

            // Handle max files and size
            this.dropzone.on("selectedfiles", function(files) {
                
                // Check for max file count
                if(self.totalFiles + files.length > self.options.max_files) {
                    MagLoft.UI.alert("Error", "You can not upload more images here.");
                    files.cancel = true;
                    return;
                }
                
                self.totalFiles += files.length;
            });
            
            // Handle deletion
            this.dropzone.on("removedfile", function(file) {
                if(file.id) {
                    self.totalFiles--;
                    $.ajax({
                        url: self.url,
                        data: {
                            id: file.id
                        },
                        type: "DELETE"
                    });                    
                }else{
                    self.totalFiles--;
                    // MagLoft.UI.alert("Error", "You can not upload more images here.");
                }
            });
            
            // Handle success
            this.dropzone.on("success", function(file, response) {
                self.options.onSuccess(file, response);
            });
            
        }

    }); 
    
    // register namespace
    $.extend(true, window, {
        "DropzoneRails": {
            "Handler": DropzoneRailsHandler
        }
    });
    
})(jQuery);
