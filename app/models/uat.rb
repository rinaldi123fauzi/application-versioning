class Uat < ActiveRecord::Base
    belongs_to :rfc
    belongs_to :penyelesaian
    belongs_to :internal
    has_one :change

    attr_accessor :id_rfc

    after_create :setStatus
    after_create :setStatusUat

    private

    def setStatus
        @getPenyelesaianId = Penyelesaian.find_by_rfc_id(id_rfc)
        @getInternalId = Internal.find_by_rfc_id(id_rfc)
        Rfc.update(id_rfc, {:status => "Waiting Release", :id_status => 4})
        Uat.update(self.id, {:rfc_id => id_rfc, :penyelesaian_id => @getPenyelesaianId.id, :internal_id => @getInternalId.id})
    end

    def setStatusUat
        @getNoTesting = Uat.find_by_rfc_id(id_rfc)
        unless @getNoTesting.nil? 
            if @getNoTesting.status == "Closed"
                @checkNoTesting = Uat.where('no_testing LIKE ?', "%#{@getNoTesting.no_testing}")
                @checkNoTesting.update(status: "Closed")
            end
        end 
    end
end
