# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151113181003) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,   null: false
    t.integer  "target_id",    limit: 4,   null: false
    t.integer  "context_id",   limit: 4,   null: false
    t.string   "action",       limit: 32
    t.string   "target_type",  limit: 255, null: false
    t.string   "context_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "resource_id",      limit: 4,     default: 1,     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "license_id",       limit: 4
    t.boolean  "deleted",                        default: false, null: false
    t.boolean  "preview_new",                    default: false, null: false
    t.boolean  "has_translations"
    t.string   "guid",             limit: 32
    t.string   "resource_pk",      limit: 255
    t.string   "title",            limit: 255
    t.string   "body",             limit: 255
    t.text     "credits_json",     limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "collection_items", force: :cascade do |t|
    t.integer  "collection_id", limit: 4,   null: false
    t.integer  "user_id",       limit: 4
    t.integer  "position",      limit: 4
    t.integer  "item_id",       limit: 4
    t.string   "item_type",     limit: 255
    t.string   "annotation",    limit: 255
    t.string   "name",          limit: 255
    t.string   "path",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: :cascade do |t|
    t.integer  "image_file_size",        limit: 4
    t.integer  "position",               limit: 4
    t.integer  "collection_items_count", limit: 4
    t.string   "name",                   limit: 255
    t.string   "description",            limit: 255
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.string   "sort_style",             limit: 32
    t.string   "view_style",             limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "on_id",         limit: 4
    t.integer  "reply_to_id",   limit: 4
    t.boolean  "deleted",                     default: false, null: false
    t.string   "on_type",       limit: 255
    t.string   "reply_to_type", limit: 255
    t.text     "body",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents_nodes", force: :cascade do |t|
    t.integer "node_id",      limit: 4
    t.integer "content_id",   limit: 4
    t.string  "content_type", limit: 255
  end

  create_table "curations", force: :cascade do |t|
    t.integer  "on_page_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "field",      limit: 255
    t.string   "from",       limit: 255
    t.string   "to",         limit: 255
    t.text     "reason",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curators", force: :cascade do |t|
    t.integer "curations_count",          limit: 4
    t.integer "node_curations_count",     limit: 4
    t.integer "exemplars_count",          limit: 4
    t.integer "names_curations_count",    limit: 4
    t.integer "images_curations_count",   limit: 4
    t.integer "articles_curations_count", limit: 4
    t.string  "curator_scope",            limit: 255
    t.string  "credentials",              limit: 255
    t.text    "bio",                      limit: 65535
  end

  create_table "embeds", force: :cascade do |t|
    t.integer  "resource_id",      limit: 4,     default: 1,     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "license_id",       limit: 4
    t.boolean  "has_translations"
    t.boolean  "deleted",                        default: false, null: false
    t.boolean  "preview_new",                    default: false, null: false
    t.string   "type",             limit: 255
    t.string   "guid",             limit: 32
    t.string   "resource_pk",      limit: 255
    t.string   "title",            limit: 255
    t.string   "description",      limit: 255
    t.string   "src",              limit: 255
    t.text     "credits_json",     limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "resource_id",        limit: 4,                               default: 1,     null: false
    t.integer  "user_id",            limit: 4
    t.integer  "license_id",         limit: 4
    t.integer  "crop_x",             limit: 4
    t.integer  "crop_y",             limit: 4
    t.integer  "crop_w",             limit: 4
    t.boolean  "deleted",                                                    default: false, null: false
    t.boolean  "preview_new",                                                default: false, null: false
    t.boolean  "has_translations"
    t.decimal  "lat",                              precision: 64, scale: 12
    t.decimal  "long",                             precision: 64, scale: 12
    t.decimal  "alt",                              precision: 64, scale: 12
    t.string   "guid",               limit: 32
    t.string   "resource_pk",        limit: 255
    t.string   "title",              limit: 255
    t.string   "description",        limit: 255
    t.string   "small_size",         limit: 8
    t.string   "small_square_size",  limit: 8
    t.string   "medium_size",        limit: 10
    t.string   "medium_square_size", limit: 10
    t.string   "large_size",         limit: 10
    t.string   "original_size",      limit: 16
    t.string   "source_url",         limit: 255
    t.string   "src",                limit: 255
    t.text     "credits_json",       limit: 65535
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer  "resource_id",      limit: 4,     default: 1,     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "license_id",       limit: 4
    t.boolean  "deleted",                        default: false, null: false
    t.boolean  "preview_new",                    default: false, null: false
    t.boolean  "has_translations"
    t.string   "guid",             limit: 32
    t.string   "resource_pk",      limit: 255
    t.string   "title",            limit: 255
    t.string   "description",      limit: 255
    t.string   "url",              limit: 255
    t.text     "credits_json",     limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "collection_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.boolean  "manager",                 default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "names", force: :cascade do |t|
    t.string  "string",         limit: 255
    t.string  "canonical_form", limit: 255
    t.string  "attribution",    limit: 255
    t.string  "parts_json",     limit: 255
    t.boolean "virus"
  end

  create_table "node_ancestors", force: :cascade do |t|
    t.integer "node_id",     limit: 4
    t.integer "ancestor_id", limit: 4
    t.integer "position",    limit: 4
    t.integer "page_id",     limit: 4
  end

  create_table "node_curations", force: :cascade do |t|
    t.integer  "node_id",    limit: 4
    t.integer  "page_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: :cascade do |t|
    t.integer "resource_id",     limit: 4,               null: false
    t.integer "site_pk",         limit: 4
    t.integer "parent_id",       limit: 4,   default: 0, null: false
    t.integer "root_id",         limit: 4
    t.integer "page_id",         limit: 4
    t.integer "lft",             limit: 4
    t.integer "rgt",             limit: 4
    t.string  "resource_pk",     limit: 255
    t.string  "rank",            limit: 255
    t.string  "original_rank",   limit: 255
    t.string  "scientific_name", limit: 255,             null: false
    t.string  "canonical_form",  limit: 255,             null: false
    t.string  "remarks",         limit: 255
  end

  create_table "on_pages", force: :cascade do |t|
    t.integer "page_id",        limit: 4
    t.integer "source_page_id", limit: 4
    t.integer "content_id",     limit: 4
    t.integer "position",       limit: 4
    t.integer "user_id",        limit: 4
    t.string  "content_type",   limit: 255
    t.boolean "visible",                    default: true,  null: false
    t.boolean "reviewed",                   default: false, null: false
    t.boolean "trusted",                    default: true,  null: false
  end

  create_table "page_ancestors", force: :cascade do |t|
    t.integer "page_id",         limit: 4
    t.integer "ancestor_id",     limit: 4
    t.integer "position",        limit: 4
    t.string  "rank",            limit: 255
    t.string  "scientific_name", limit: 255, null: false
    t.string  "canonical_form",  limit: 255, null: false
    t.string  "common_name_en",  limit: 255
  end

  create_table "pages", force: :cascade do |t|
    t.integer "scientific_name_id", limit: 4
    t.integer "common_name_id",     limit: 4
    t.string  "canonical_form",     limit: 255
    t.string  "scientific_name",    limit: 255
    t.string  "common_name_en",     limit: 255
    t.text    "common_names_json",  limit: 65535
  end

  create_table "pages_uris", force: :cascade do |t|
    t.integer "page_id",      limit: 4
    t.integer "known_uri_id", limit: 4
  end

  create_table "partners", force: :cascade do |t|
    t.integer  "site_id",      limit: 4,     default: 1,     null: false
    t.integer  "site_pk",      limit: 4
    t.string   "name",         limit: 255,                   null: false
    t.string   "acronym",      limit: 16,    default: "",    null: false
    t.string   "short_name",   limit: 32,    default: "",    null: false
    t.string   "url",          limit: 255,   default: "",    null: false
    t.text     "description",  limit: 65535,                 null: false
    t.string   "links_json",   limit: 255,   default: "{}",  null: false
    t.boolean  "auto_publish",               default: false, null: false
    t.boolean  "not_trusted",                default: false, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "partners_users", force: :cascade do |t|
    t.integer "user_id",    limit: 4
    t.integer "partner_id", limit: 4
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "by_user_id", limit: 4
    t.string   "permission", limit: 255
    t.boolean  "allowed",                default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", force: :cascade do |t|
  end

  create_table "references", force: :cascade do |t|
    t.integer "parent_id",   limit: 4
    t.string  "parent_type", limit: 255
    t.string  "description", limit: 255
    t.string  "url",         limit: 255
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "site_id",                   limit: 4,   default: 1,     null: false
    t.integer  "site_pk",                   limit: 4
    t.integer  "position",                  limit: 4
    t.integer  "min_days_between_harvests", limit: 4,   default: 0,     null: false
    t.integer  "harvest_day_of_month",      limit: 4
    t.integer  "last_harvest_minutes",      limit: 4
    t.integer  "nodes_count",               limit: 4
    t.string   "harvest_months_json",       limit: 255, default: "[]",  null: false
    t.string   "name",                      limit: 255,                 null: false
    t.string   "harvest_from",              limit: 255,                 null: false
    t.string   "pk_url",                    limit: 255, default: "$PK", null: false
    t.string   "cite_as",                   limit: 255
    t.boolean  "auto_publish",                          default: false, null: false
    t.boolean  "not_trusted",                           default: false, null: false
    t.boolean  "stop_harvesting",                       default: false, null: false
    t.boolean  "has_duplicate_taxa",                    default: false, null: false
    t.boolean  "force_harvest",                         default: false, null: false
    t.datetime "published_at"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "scientific_names", force: :cascade do |t|
    t.integer "name_id",        limit: 4
    t.integer "resource_id",    limit: 4
    t.integer "node_id",        limit: 4
    t.boolean "deleted",                    default: false,       null: false
    t.boolean "preview_new",                default: false,       null: false
    t.string  "type",           limit: 255, default: "preferred", null: false
    t.string  "string",         limit: 255
    t.string  "canonical_form", limit: 255
  end

  create_table "sections", force: :cascade do |t|
    t.integer "content_id",   limit: 4
    t.string  "content_type", limit: 255
    t.string  "key",          limit: 255
  end

  create_table "sounds", force: :cascade do |t|
    t.integer  "resource_id",      limit: 4,                               default: 1,     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "license_id",       limit: 4
    t.boolean  "deleted",                                                  default: false, null: false
    t.boolean  "preview_new",                                              default: false, null: false
    t.boolean  "has_translations"
    t.decimal  "lat",                            precision: 64, scale: 12
    t.decimal  "long",                           precision: 64, scale: 12
    t.decimal  "alt",                            precision: 64, scale: 12
    t.string   "guid",             limit: 32
    t.string   "resource_pk",      limit: 255
    t.string   "title",            limit: 255
    t.string   "description",      limit: 255
    t.string   "source_url",       limit: 255
    t.string   "src",              limit: 255
    t.string   "format",           limit: 255
    t.text     "credits_json",     limit: 65535
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "traits", force: :cascade do |t|
    t.integer  "resource_id",      limit: 4,     default: 1,     null: false
    t.integer  "user_id",          limit: 4
    t.boolean  "deleted",                        default: false, null: false
    t.boolean  "preview_new",                    default: false, null: false
    t.string   "guid",             limit: 32
    t.string   "resource_pk",      limit: 255
    t.string   "predicate_uri_id", limit: 255
    t.string   "value",            limit: 255
    t.string   "original_value",   limit: 255
    t.string   "value_type",       limit: 255
    t.string   "units",            limit: 255
    t.string   "original_units",   limit: 255
    t.text     "metadata_json",    limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "translations", force: :cascade do |t|
    t.integer "source_content_id",     limit: 4
    t.integer "modified_content_id",   limit: 4
    t.integer "resource_id",           limit: 4,   default: 1, null: false
    t.integer "user_id",               limit: 4
    t.string  "source_content_type",   limit: 255
    t.string  "modified_content_type", limit: 255
  end

  create_table "uris", force: :cascade do |t|
    t.string   "uri",                  limit: 255
    t.string   "name",                 limit: 255
    t.string   "definition",           limit: 255
    t.string   "comments",             limit: 255
    t.string   "attribution",          limit: 255
    t.string   "info_url",             limit: 255
    t.string   "source_url",           limit: 255
    t.integer  "position",             limit: 4
    t.boolean  "hide_definition",                  default: false, null: false
    t.boolean  "hide_from_exemplars",              default: false, null: false
    t.boolean  "hide_from_glossary",               default: false, null: false
    t.boolean  "hide_from_gui",                    default: false, null: false
    t.boolean  "hide_from_predicates",             default: false, null: false
    t.boolean  "hide_from_values",                 default: false, null: false
    t.boolean  "normalize_value",                  default: true,  null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "failed_login_attempts",     limit: 4
    t.integer  "image_file_size",           limit: 4
    t.integer  "comments_count",            limit: 4
    t.integer  "contents_count",            limit: 4
    t.integer  "names_contents_count",      limit: 4
    t.integer  "articles_contents_count",   limit: 4
    t.integer  "images_contents_count",     limit: 4
    t.integer  "traits_contents_count",     limit: 4
    t.integer  "notification_setting_id",   limit: 4
    t.integer  "curator_id",                limit: 4
    t.integer  "email_frequency_days",      limit: 4
    t.boolean  "active",                                default: false,  null: false
    t.boolean  "deleted",                               default: false,  null: false
    t.boolean  "email_ok",                              default: true,   null: false
    t.boolean  "admin",                                 default: false,  null: false
    t.string   "username",                  limit: 32
    t.string   "language",                  limit: 8
    t.string   "email",                     limit: 255
    t.string   "provider",                  limit: 255
    t.string   "uid",                       limit: 255
    t.string   "url",                       limit: 255
    t.string   "location",                  limit: 255
    t.string   "name",                      limit: 64
    t.string   "tagline",                   limit: 64
    t.string   "password_hash",             limit: 255
    t.string   "api_key",                   limit: 255
    t.string   "image_url",                 limit: 255
    t.string   "image_file_name",           limit: 255
    t.string   "image_content_type",        limit: 255
    t.string   "curator_type",              limit: 16,  default: "none"
    t.string   "requested_curator_type",    limit: 16,  default: "none"
    t.string   "code",                      limit: 255
    t.datetime "code_expires_at"
    t.datetime "curator_type_requested_at"
    t.datetime "last_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vernaculars", force: :cascade do |t|
    t.integer "name_id",               limit: 4
    t.integer "resource_id",           limit: 4
    t.integer "node_id",               limit: 4
    t.boolean "preferred",                         default: false, null: false
    t.boolean "preferred_by_resource",             default: false, null: false
    t.boolean "deleted",                           default: false, null: false
    t.boolean "preview_new",                       default: false, null: false
    t.string  "language",              limit: 8
    t.string  "string",                limit: 255
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "resource_id",      limit: 4,                               default: 1,     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "license_id",       limit: 4
    t.boolean  "deleted",                                                  default: false, null: false
    t.boolean  "preview_new",                                              default: false, null: false
    t.boolean  "has_translations"
    t.decimal  "lat",                            precision: 64, scale: 12
    t.decimal  "long",                           precision: 64, scale: 12
    t.decimal  "alt",                            precision: 64, scale: 12
    t.string   "guid",             limit: 32
    t.string   "resource_pk",      limit: 255
    t.string   "title",            limit: 255
    t.string   "description",      limit: 255
    t.string   "source_url",       limit: 255
    t.string   "src",              limit: 255
    t.string   "format",           limit: 255
    t.text     "credits_json",     limit: 65535
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "watches", force: :cascade do |t|
    t.integer  "user_id",       limit: 4,   null: false
    t.integer  "watching_id",   limit: 4,   null: false
    t.string   "watching_type", limit: 255, null: false
    t.datetime "created_at",                null: false
  end

end
