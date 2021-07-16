class Aplikasi < ActiveRecord::Base
    has_many :rfc, dependent: :destroy
    default_scope { order(divisi: :asc) }

    def aplikasi
        "#{self.id_aplikasi} - #{self.nama_aplikasi}" 
    end
end
