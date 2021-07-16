class Internal < ActiveRecord::Base
    belongs_to :rfc
    belongs_to :penyelesaian
    has_one :uat
    has_one :change

    attr_accessor :id_rfc

    after_create :setStatus

    private

    def setStatus
        @getPenyelesaianId = Penyelesaian.find_by_rfc_id(id_rfc)
        Rfc.update(id_rfc, {:status => "Waiting UAT", :id_status => 3})
        Internal.update(self.id, {:rfc_id => id_rfc, :penyelesaian_id => @getPenyelesaianId.id})
    end
end

