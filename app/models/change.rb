class Change < ActiveRecord::Base
    belongs_to :rfc
    belongs_to :penyelesaian
    belongs_to :uat 
    belongs_to :internal

    attr_accessor :id_rfc

    after_create :setStatus

    private

    def setStatus
        @getOwner = Rfc.find(id_rfc)
        @getPenyelesaianId = Penyelesaian.find_by_rfc_id(id_rfc)
        @getInternalId = Internal.find_by_rfc_id(id_rfc)
        @getUatId = Uat.find_by_rfc_id(id_rfc)
        Rfc.update(id_rfc, {:status => "Closed", :id_status => 5})
        Change.update(self.id, {:pemilik_proses => @getOwner.aplikasi.pemilik_proses, :rfc_id => id_rfc, :penyelesaian_id => @getPenyelesaianId.id, :internal_id => @getInternalId.id, :uat_id => @getUatId.id, :aplikasi_id => @getOwner.aplikasi_id, :no_testing => @getUatId.no_testing})
    end
end
