# IMPORTANT NOTE ON MIGRATIONS: the database of this project is SHARED by the
# website project! Thus any changes you make here will affect the website. I'm
# not sure I like that, and it might be a strong argument against the
# separation. Something to think about. In the meantime, I'm going to preserve
# the migrations for THIS project, and leave them blank in the other.
class InitialSchema < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      # The ID of the remote EOL site that created this partner:
      t.integer :site_id, null: false, default: Rails.configuration.site_id
      # The PK that the remote site uses for this partner. ...This allows us to
      # use our own simple, local IDs; when we're talking to a remote site, we
      # can use these IDs, but by and large, we don't actually need them! Null
      # IS allowed, and implies "there is no PK, just use our local ID."
      t.integer :site_pk
      t.string :name, null: false
      t.string :acronym, null: false, limit: 16, default: ""
      t.string :short_name, null: false, limit: 32, default: ""
      t.string :url, null: false, default: ""
      t.text :description, null: false
      # links_json used for creating arbitrary pairs of link names/urls:
      t.string :links_json, null: false, default: "{}"
      # auto_publish applies to _all_ resources!
      t.boolean :auto_publish, null: false, default: false
      # not_trusted applies to _all_ resources!
      t.boolean :not_trusted, null: false, default: false
      t.timestamps null: false
    end

    create_table :resources do |t|
      t.integer :site_id, null: false, default: Rails.configuration.site_id
      t.integer :site_pk
      # position for sorting. Lower position means high-priority harvesting
      t.integer :position
      t.integer :min_days_between_harvests, null: false, default: 0
      # If harvest_day_of_month is null, use min_days_between_harvests
      t.integer :harvest_day_of_month
      t.integer :last_harvest_minutes
      t.integer :nodes_count
      # harvest_months_json is an array of month numbers (1 is January) to run
      # harvests; empty means "any month is okay"
      t.string :harvest_months_json, null: false, default: "[]"
      t.string :name, null: false
      # harvest_from could be a URL or a path; the code must check.
      t.string :harvest_from, null: false
      t.string :pk_url, null: false, default: "$PK"
      # cite_as could be (often is) the name of the partner:
      t.string :cite_as
      t.boolean :auto_publish, null: false, default: false
      t.boolean :not_trusted, null: false, default: false
      t.boolean :stop_harvesting, null: false, default: false
      t.boolean :has_duplicate_taxa, null: false, default: false
      t.boolean :force_harvest, null: false, default: false
      t.datetime :published_at
      t.timestamps null: false
    end

    create_table :nodes do |t|
      t.integer :resource_id, null: false
      t.integer :site_pk
      t.integer :parent_id, null: false, default: 0
      t.integer :root_id
      t.integer :page_id
      t.integer :lft
      t.integer :rgt
      t.string :resource_pk
      t.string :rank
      t.string :original_rank
      t.string :scientific_name, null: false
      t.string :canonical_form, null: false
      t.string :remarks # TODO: is this the same as references?
    end

    create_table :node_ancestors do |t|
      t.integer :node_id
      t.integer :ancestor_id
      t.integer :position
      t.integer :page_id
    end

    # Store "natively" what we need to lookup; "cache" what we regularly need to
    # render, but not lookup.
    create_table :pages do |t|
      # We'll look scientific_name_id up to detect changes
      t.integer :scientific_name_id
      # We'll look common_name_id up to detect changes
      t.integer :common_name_id
      # canonical_form is just a stripped version of the scientific_name
      t.string :canonical_form
      # We need this to render almost all the time; simplifies everything.
      t.string :scientific_name
      # We need this to render almost all the time; simplifies everything.
      t.string :common_name_en
      t.text :common_names_json
    end

    create_table :page_ancestors do |t|
      t.integer :page_id
      t.integer :ancestor_id
      t.integer :position
      t.string :rank
      t.string :scientific_name, null: false
      t.string :canonical_form, null: false
      t.string :common_name_en
    end

    # This is used for lookup of matching names, mainly, and to store GNA stuff
    create_table :names do |t|
      t.string :string
      t.string :canonical_form
      t.string :attribution
      t.string :parts_json
      t.boolean :virus
    end

    create_table :vernaculars do |t|
      t.integer :name_id
      t.integer :resource_id
      t.integer :node_id
      t.boolean :preferred, null: false, default: false
      t.boolean :preferred_by_resource, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      t.string :language, limit: 8 # Enum
      t.string :string
    end

    create_table :scientific_names do |t|
      t.integer :name_id
      t.integer :resource_id
      t.integer :node_id
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      # Enum:
      t.string :type, null: false, default: "preferred"
      t.string :string # D name.string
      t.string :canonical_form # D name.canonical_form
    end

    create_table :images do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      # Ignored unless resource_id == Rails.configuration.users_resource_id
      t.integer :user_id
      t.integer :license_id
      # Note that crops are always square, and are ALWAYS performed on the
      # "large" size, so you can get percentages by reading that size.
      t.integer :crop_x
      t.integer :crop_y
      t.integer :crop_w
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      # Simple flag to know whether or not to bother looking:
      t.boolean :has_translations
      t.decimal :lat, precision: 64, scale: 12
      t.decimal :long, precision: 64, scale: 12
      t.decimal :alt, precision: 64, scale: 12
      t.string :guid, limit: 32
      t.string :resource_pk
      # HTML:
      t.string :title
      # HTML:
      t.string :description
      t.string :small_size, limit: 8
      t.string :small_square_size, limit: 8
      t.string :medium_size, limit: 10
      t.string :medium_square_size, limit: 10
      t.string :large_size, limit: 10
      t.string :original_size, limit: 16
      t.text :urls_json
      # This can be modified; strip the extension and add one of the following:
      # %w( _smsq _sm _mdsq _md _lg ) ...Without these, you get the full size.
      t.string :src
      # Note that this can include "spatial location" from EOL2:
      t.text :credits_json
      t.timestamps null: false
    end

    create_table :videos do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.integer :license_id
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      # Simple flag to know whether or not to bother looking:
      t.boolean :has_translations
      t.decimal :lat, precision: 64, scale: 12
      t.decimal :long, precision: 64, scale: 12
      t.decimal :alt, precision: 64, scale: 12
      t.string :guid, limit: 32
      t.string :resource_pk
      # HTML:
      t.string :title
      # HTML:
      t.string :description
      t.string :source_url
      t.string :src
      t.string :format
      # Note that this can include "spatial location" from EOL2:
      t.text :credits_json
      t.timestamps null: false
    end

    create_table :sounds do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.integer :license_id
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      # Simple flag to know whether or not to bother looking:
      t.boolean :has_translations
      t.decimal :lat, precision: 64, scale: 12
      t.decimal :long, precision: 64, scale: 12
      t.decimal :alt, precision: 64, scale: 12
      t.string :guid, limit: 32
      t.string :resource_pk
      # HTML:
      t.string :title
      # HTML:
      t.string :description
      t.string :source_url
      t.string :src
      t.string :format
      # Note that this can include "spatial location" from EOL2:
      t.text :credits_json
      t.timestamps null: false
    end

    create_table :articles do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.integer :license_id
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      t.boolean :has_translations
      t.string :guid, limit: 32
      t.string :resource_pk
      # HTML:
      t.string :title
      # HTML:
      t.string :body
      t.text :credits_json
      t.timestamps null: false
    end

    create_table :links do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.integer :license_id
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      t.boolean :has_translations
      t.string :guid, limit: 32
      t.string :resource_pk
      # HTML:
      t.string :title
      # HTML:
      t.string :description
      t.string :url
      t.text :credits_json
      t.timestamps null: false
    end

    create_table :traits do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      t.string :guid, limit: 32
      t.string :resource_pk
      t.string :predicate_uri_id
      t.string :value
      t.string :original_value
      # Enumerable: string, integer, float, page, or uri_id
      t.string :value_type
      t.string :units
      t.string :original_units
      t.text :metadata_json
      t.timestamps null: false
    end

    # A kind of "miscelaneous" bucket which can handle scripts/flash/html5/etc:
    create_table :embeds do |t|
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.integer :license_id
      t.boolean :has_translations
      t.boolean :deleted, null: false, default: false
      t.boolean :preview_new, null: false, default: false
      # Enumerable:
      t.string :type
      t.string :guid, limit: 32
      t.string :resource_pk
      # HTML:
      t.string :title
      # HTML:
      t.string :description
      t.string :src
      t.text :credits_json
      t.timestamps null: false
    end

    create_table :sections do |t|
      t.integer :content_id
      t.string :content_type
      # Enumerable; fed to I18n:
      t.string :key
    end

    create_table :translations do |t|
      t.integer :source_content_id
      t.integer :modified_content_id
      t.integer :resource_id, null: false,
        default: Rails.configuration.users_resource_id
      t.integer :user_id
      t.string :source_content_type
      t.string :modified_content_type
    end

    # Primarily for BHL:
    create_table :publications do |t|
      # TODO
    end

    create_table :references do |t|
      # Parent can either be content or a node.
      t.integer :parent_id
      t.string :parent_type
      # HTML:
      t.string :description
      t.string :url
    end

    # There are cases where we want to know how content got onto a page it's on;
    # this tells us which node(s) specifically contributed the content.
    create_table :contents_nodes do |t|
      t.integer :node_id
      t.integer :content_id
      t.string :content_type
    end

    create_table :on_pages do |t|
      t.integer :page_id
      # If page_id != source_page_id, you are looking at a propagated
      # association (via ancestry); this tells you where it actually happened:
      t.integer :source_page_id
      t.integer :content_id
      t.integer :position
      # Only populated when a curator added this association: TODO: when a page
      # is _split_ and there are curator-added associations, we will have to
      # prompt them to review each, and tell us which page it belongs on.
      t.integer :user_id
      t.string :content_type
      t.boolean :visible, null: false, default: true
      t.boolean :reviewed, null: false, default: false
      t.boolean :trusted, null: false, default: true
    end

    create_table :curations do |t|
      t.integer :on_page_id
      t.integer :user_id
      t.string :field
      t.string :from
      t.string :to
      # Note that the UI will allow some canned responses to reason (albeit
      # stored in the user's original language, but I think that's fine):
      t.text :reason
      t.timestamps
    end

    create_table :node_curations do |t|
      t.integer :node_id
      t.integer :page_id
      t.integer :user_id
      t.timestamps
    end

    # Just a denormalized table to speed up building a glossary, which is
    # otherwise quite expensive!
    create_table :pages_uris do |t|
      t.integer :page_id
      t.integer :known_uri_id
    end

    # URIs are only available in English... for now. We might add a rake task
    # that adds them to en.yml and allows translations, but the en is still in
    # the DB...
    create_table :uris do |t|
      t.string :uri
      t.string :name
      t.string :definition
      t.string :comments
      t.string :attribution
      t.string :info_url
      t.string :source_url
      t.integer :position
      t.boolean :hide_definition, null: false, default: false
      t.boolean :hide_from_exemplars, null: false, default: false
      t.boolean :hide_from_glossary, null: false, default: false
      t.boolean :hide_from_gui, null: false, default: false
      t.boolean :hide_from_predicates, null: false, default: false
      t.boolean :hide_from_values, null: false, default: false
      t.boolean :normalize_value, null: false, default: true
      t.timestamps null: false
    end

    # NOTE: yes, this is a really large table, but I don't see a great place to
    # break it up. We could extract the "manually counted" stuff, but I don't
    # see that as a huge win. :\ TODO: as we add anti-spam gems, I expect to add
    # a field or two to this.
    create_table :users do |t|
      t.integer :failed_login_attempts
      t.integer :image_file_size
      # Counter-culture:
      t.integer :comments_count
      t.integer :contents_count
      # Manually counted (unless Counter-culture can handle scopes?):
      t.integer :names_contents_count
      t.integer :articles_contents_count
      t.integer :images_contents_count
      t.integer :traits_contents_count
      # One-to-one:
      t.integer :notification_setting_id
      t.integer :curator_id
      t.integer :email_frequency_days
      # Default false, until they click the activate link from email:
      t.boolean :active, null: false, default: false
      t.boolean :deleted, null: false, default: false
      # NOTE: this _could_ have been a permission, but it will required often
      # enough that this should be more efficient:
      t.boolean :email_ok, null: false, default: true
      t.boolean :admin, null: false, default: false
      t.string :username, limit: 32
      t.string :language, limit: 8 # Enum
      t.string :email
      # OpenID, http://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/
      t.string :provider
      t.string :uid
      t.string :url
      t.string :location
      # We never ever ever break up the name for anything, ever. So let's just:
      t.string :name, limit: 64
      t.string :tagline, limit: 64
      t.string :password_hash
      t.string :api_key
      t.string :image_url
      t.string :image_file_name
      t.string :image_content_type
      # Enumerable: none assistant full master
      t.string :curator_type, default: "none", limit: 16
      t.string :requested_curator_type, default: "none", limit: 16
      # Used for email validation of various sorts:
      t.string :code
      t.datetime :code_expires_at
      t.datetime :curator_type_requested_at
      t.datetime :last_email
      t.timestamps
    end

    # Addt'l information, to declutter the user table:
    create_table :curators do |t|
      # counter culture:
      t.integer :curations_count
      t.integer :node_curations_count
      # manually counted:
      t.integer :exemplars_count
      t.integer :names_curations_count
      t.integer :images_curations_count
      t.integer :articles_curations_count
      t.string :curator_scope
      t.string :credentials
      t.text :bio
    end

    create_table :partners_users do |t|
      t.integer :user_id
      t.integer :partner_id
    end

    create_table :permissions do |t|
      t.integer :user_id
      t.integer :by_user_id
      # Enumerable (because a small, known set are allowed in the code!)
      t.string :permission
      # If an admin turns it OFF, we want to see who did it and when, so:
      t.boolean :allowed, null: false, default: true
      t.timestamps
    end

    create_table :comments do |t|
      t.integer :user_id
      t.integer :on_id
      t.integer :reply_to_id
      t.boolean :deleted, null: false, default: false
      t.string :on_type
      t.string :reply_to_type
      # HTML:
      t.text :body
      t.timestamps
    end

    create_table :watches do |t|
      t.integer :user_id, null: false
      t.integer :watching_id, null: false
      t.string :watching_type, null: false
      t.datetime :created_at, null: false
    end

    # Jack added common name "penguin" to page 36.
    # Jill split node "Acer silvestrus" from page 6542.
    # Katy merged page 2345 with page 6542.
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.integer :target_id, null: false
      t.integer :context_id, null: false
      # Enumerable: e.g.: comment, hide, watch, collect, etc...
      t.string :action, limit: 32
      t.string :target_type, null: false
      t.string :context_type
      t.timestamps
    end

    create_table :collections do |t|
      t.integer :image_file_size
      # For ranking which collections are most "interesting":
      t.integer :position
      t.integer :collection_items_count
      t.string :name
      t.string :description
      t.string :image_file_name
      t.string :image_content_type
      # Enum:
      t.string :sort_style, limit: 32
      # Enum:
      t.string :view_style, limit: 32
      t.timestamps
    end

    create_table :members do |t|
      t.integer :collection_id
      t.integer :user_id
      t.boolean :manager, null: false, default: false
      t.timestamps
    end

    create_table :collection_items do |t|
      t.integer :collection_id, null: false
      # Added by:
      t.integer :user_id
      t.integer :position
      t.integer :item_id
      t.string :item_type
      t.string :annotation
      t.string :name
      t.string :path # D
      t.timestamps
    end
  end
end
