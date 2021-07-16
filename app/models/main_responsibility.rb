class MainResponsibility < ActiveRecord::Base
  belongs_to :staff

  attr_accessor :nama_pembuat

  after_create :setIssued

  private

  def setIssued
      MainResponsibility.update(self.id, :issued_by => nama_pembuat)
  end
end
