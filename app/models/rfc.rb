class Rfc < ActiveRecord::Base
    has_one :penyelesaian, dependent: :destroy
    has_one :internal, dependent: :destroy
    has_one :uat, dependent: :destroy
    has_one :change, dependent: :destroy
    belongs_to :aplikasi
    belongs_to :category
    belongs_to :risiko
    belongs_to :priority
    
    attr_accessor :nama_user

    after_create :setStatusdanIssued

    private

    def setStatusdanIssued
        Rfc.update(self.id, {:status => "Open", :issued_by => nama_user, :id_status => 1})
    end
end
