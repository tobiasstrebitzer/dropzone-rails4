abort "works"

require "dropzone/version"

module Dropzone

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
     attr_accessor :default_image, :filetype, :include_size_attributes,
       :rating, :size, :secure

     def initialize
        @include_size_attributes = true
     end
  end

  def self.included(base)
    abort "ok"
    GravatarImageTag.configure { |c| nil }
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def kitten(options = {})
      options[:src] = "http://placekitten.com.s3.amazonaws.com/homepage-samples/200/287.jpg"
      options[:alt] = 'Kitten'
      tag 'img', options, false, false
    end

  end

#  def filemanager(entity, options, profile)
#
#    # get config
#    config = Magster::Application.config.filemanager[:profiles][profile]
#
#    abort config.inspect
#
#    # set options defaults
#    options.reverse_merge!(
#      :class => 'AppProfileImage',
#      :field => 'image',
#      :max_files => 1,
#      :width => nil,
#      :filetypes => ['image/jpeg', 'image/png']
#    )
#
#    # get entity info
#    id_field = "#{entity.class.name.underscore}_id"
#
#    # get class info
#    klass = options[:class].constantize
#    klass_slug = klass.name.underscore
#    path = polymorphic_path(klass)
#    relation_field = options[:class].underscore.pluralize
#
#    # get html info
#    if !options[:width].nil?
#      style = "style='width: #{options[:width]}px;'"
#    end
#
#    # generate html
#    html = "<div #{style} class='file-manager' data-filetypes='#{options[:filetypes].join(",")}' data-delete-url='#{path}/{id}.json' data-upload-url='#{path}.json' data-max-files='#{options[:max_files]}' data-params='#{klass_slug}[#{id_field}]=#{entity.id};#{klass_slug}[key]=#{options[:key]}' data-param='#{klass_slug}[#{options[:field]}]'>"
#    entity.send(relation_field).with_key(options[:key]).each do |relation|
#      html += "<i data-name='#{relation.image_file_name}' data-size='#{relation.image_file_size}' data-src='#{relation.image(:dropzone)}' data-id='#{relation.id}'></i>"
#    end
#    html += "</div>"
#
#    raw(html)
#  end

end

ActionView::Base.send(:include, Dropzone) if defined?(ActionView::Base)