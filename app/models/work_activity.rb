class WorkActivity < ActiveRecord::Base
  belongs_to :staff
  attr_accessor :nama_pembuat
  has_many_attached :lampiran

  after_create :setIssued_and_Date

  private

  def setIssued_and_Date
      @tahun = self.periode_waktu.strftime("%Y")
      @bulan = self.periode_waktu.strftime("%m")
      WorkActivity.update(self.id, {:issued_by => nama_pembuat, :tahun => @tahun, :bulan => @bulan})
  end
end
