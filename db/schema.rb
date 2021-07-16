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

ActiveRecord::Schema.define(version: 2021_07_11_132040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "api_tests", force: :cascade do |t|
    t.string "nama"
    t.string "alamat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "aplikasis", force: :cascade do |t|
    t.string "id_aplikasi"
    t.string "kode"
    t.string "nama_aplikasi"
    t.string "deskripsi"
    t.string "pemilik_proses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "default_version"
    t.string "divisi"
    t.string "status"
  end

  create_table "audit_trails", force: :cascade do |t|
    t.string "user"
    t.string "description"
    t.string "controller"
    t.string "action"
    t.string "browser"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "nama"
    t.string "deskripsi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "changes", force: :cascade do |t|
    t.date "tgl_release"
    t.string "pemilik_proses"
    t.string "versi_sourcecode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "uat_id"
    t.bigint "rfc_id"
    t.bigint "penyelesaian_id"
    t.bigint "internal_id"
    t.bigint "aplikasi_id"
    t.string "no_testing"
    t.index ["aplikasi_id"], name: "index_changes_on_aplikasi_id"
    t.index ["internal_id"], name: "index_changes_on_internal_id"
    t.index ["penyelesaian_id"], name: "index_changes_on_penyelesaian_id"
    t.index ["rfc_id"], name: "index_changes_on_rfc_id"
    t.index ["uat_id"], name: "index_changes_on_uat_id"
  end

  create_table "internals", force: :cascade do |t|
    t.date "tgl_testing"
    t.string "penguji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "penyelesaian_id"
    t.bigint "rfc_id"
    t.index ["penyelesaian_id"], name: "index_internals_on_penyelesaian_id"
    t.index ["rfc_id"], name: "index_internals_on_rfc_id"
  end

  create_table "main_responsibilities", force: :cascade do |t|
    t.bigint "staff_id"
    t.string "tanggung_jawab_utama"
    t.string "aktivitas"
    t.string "output"
    t.string "periode"
    t.integer "frekuensi"
    t.integer "menit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "issued_by"
    t.index ["staff_id"], name: "index_main_responsibilities_on_staff_id"
  end

  create_table "penyelesaians", force: :cascade do |t|
    t.string "kode_penyelesaian"
    t.date "tgl_selesai"
    t.string "durasi"
    t.string "pic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rfc_id"
    t.string "status"
    t.index ["rfc_id"], name: "index_penyelesaians_on_rfc_id"
  end

  create_table "priorities", force: :cascade do |t|
    t.string "nama"
    t.string "deskripsi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rfcs", force: :cascade do |t|
    t.string "no_registrasi_perubahan"
    t.string "versi_aplikasi"
    t.string "uraian_perubahan"
    t.string "link"
    t.string "tanggal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.bigint "priority_id"
    t.bigint "risiko_id"
    t.bigint "category_id"
    t.bigint "aplikasi_id"
    t.string "issued_by"
    t.integer "id_status"
    t.string "status_uraian"
    t.index ["aplikasi_id"], name: "index_rfcs_on_aplikasi_id"
    t.index ["category_id"], name: "index_rfcs_on_category_id"
    t.index ["priority_id"], name: "index_rfcs_on_priority_id"
    t.index ["risiko_id"], name: "index_rfcs_on_risiko_id"
  end

  create_table "risikos", force: :cascade do |t|
    t.string "nama"
    t.string "deskripsi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_assignments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_role_assignments_on_role_id"
    t.index ["user_id"], name: "index_role_assignments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "permissions"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string "nama"
    t.string "jabatan"
    t.string "satuan_kerja"
    t.string "status_kepegawaian"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uats", force: :cascade do |t|
    t.string "no_testing"
    t.date "tgl_testing"
    t.string "penguji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "internal_id"
    t.bigint "rfc_id"
    t.bigint "penyelesaian_id"
    t.string "status"
    t.index ["internal_id"], name: "index_uats_on_internal_id"
    t.index ["penyelesaian_id"], name: "index_uats_on_penyelesaian_id"
    t.index ["rfc_id"], name: "index_uats_on_rfc_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "name"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "sign_in_count"
    t.string "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_activities", force: :cascade do |t|
    t.bigint "staff_id"
    t.date "periode_waktu"
    t.string "aktivitas"
    t.string "waktu_per_aktivitas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tahun"
    t.string "issued_by"
    t.string "bulan"
    t.index ["staff_id"], name: "index_work_activities_on_staff_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "changes", "aplikasis"
  add_foreign_key "changes", "internals"
  add_foreign_key "changes", "penyelesaians"
  add_foreign_key "changes", "rfcs"
  add_foreign_key "changes", "uats"
  add_foreign_key "internals", "penyelesaians"
  add_foreign_key "internals", "rfcs"
  add_foreign_key "main_responsibilities", "staffs"
  add_foreign_key "penyelesaians", "rfcs"
  add_foreign_key "rfcs", "aplikasis"
  add_foreign_key "rfcs", "categories"
  add_foreign_key "rfcs", "priorities"
  add_foreign_key "rfcs", "risikos"
  add_foreign_key "role_assignments", "roles"
  add_foreign_key "role_assignments", "users"
  add_foreign_key "uats", "internals"
  add_foreign_key "uats", "penyelesaians"
  add_foreign_key "uats", "rfcs"
  add_foreign_key "work_activities", "staffs"
end
