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
      t.timestamps, null: false
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
      t.timestamps, null: false
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
      t.string :name, null: false
      t.string :remarks # TODO: is this the same as literature_references?
      t.string :ancestors_json, null: false, default: "{}"
    end

    # Store "natively" what we need to lookup; "cache" what we regularly need to
    # render, but not lookup.
    create_table :pages do |t|
      # We'll look scientific_name_id up to detect changes
      t.integer scientific_name_id
      # We'll look common_name_id up to detect changes
      t.integer common_name_id
      # canonical_form is just a stripped version of the scientific_name
      t.string canonical_form
      # We need this to render almost all the time; simplifies everything.
      t.string scientific_name
      # We need this to render almost all the time; simplifies everything.
      t.string common_name_en
      t.text common_names_json
      # An array something like [{rank: "kingdom",
      #   scientific_name: "Animalia Lin.", canonical_form: "Animalia",
      #   scientific_name_id: 12 }, etc...]
      t.text ancestors_json
    end

    # This is used for lookup of matching names, mainly, and to store GNA stuff
    create_table :names do |t|
      t.string :string
      t.string :canonical_form
      t.string :attribution
      t.string :parts_json
      t.boolean :virus
    end

    create_table :common_names do |t|
      t.integer :name_id
      t.integer :resource_id
      t.integer :node_id
      t.integer :language_id
      t.string :string
    end

    create_table :scientific_names do |t|
      t.integer :name_id
      t.integer :resource_id
      t.integer :node_id
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
      t.float :lat
      t.float :long
      t.string :resource_pk
      t.string :title_html
      t.string :description_html
      t.string :small_size, limit: 8
      t.string :small_square_size, limit: 8
      t.string :medium_size, limit: 10
      t.string :medium_square_size, limit: 10
      t.string :large_size, limit: 10
      t.string :original_size, limit: 16
      t.string :source_url
      # This can be modified; strip the extension and add one of the following:
      # %w( _smsq _sm _mdsq _md _lg ) ...Without these, you get the full size.
      t.string :src
      t.text :credits_json
    end

    create_table :videos do |t|
    end

    create_table :sounds do |t|
    end

    create_table :articles do |t|
    end

    create_table :links do |t|
    end

    create_table :traits do |t|
    end

    # A kind of "miscelaneous" bucket which can handle scripts/flash/html5/etc:
    create_table :embeds do |t|
    end
  end
end
