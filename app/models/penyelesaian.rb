class Penyelesaian < ActiveRecord::Base
    belongs_to :rfc
    has_one :internal
    has_one :uat
    has_one :change

    attr_accessor :id_rfc

    after_create :setStatus
    after_create :setStatusPenyelesaian

    private

    def setStatus
        Rfc.update(id_rfc, {:status => "Waiting Quality Check", :id_status => 2})
        Penyelesaian.update(self.id, :rfc_id => id_rfc)
    end

    def setStatusPenyelesaian
        @getKodePenyelesaian = Penyelesaian.find_by_rfc_id(id_rfc)
        unless @getKodePenyelesaian.nil? 
            if @getKodePenyelesaian.status == "Closed"
                @checkKodePenyelesaian = Penyelesaian.where('kode_penyelesaian LIKE ?', "%#{@getKodePenyelesaian.kode_penyelesaian}")
                @checkKodePenyelesaian.update(status: "Closed")
            end
        end 
    end
end
