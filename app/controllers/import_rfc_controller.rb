class ImportRfcController < ApplicationController
  def create
    folder_path = File.join('excel')

    FileUtils.rm_rf(Dir['lib/excel/*'])

    if !Dir.exist? folder_path
      FileUtils::mkdir_p (Rails.root.join('lib', folder_path))
    end

    uploaded_io = params[:import_rfc][:items_import]

    file_path = File.join(folder_path, uploaded_io.original_filename)
    File.open(Rails.root.join('lib', file_path), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    data = Roo::Spreadsheet.open('lib/excel/' + params[:import_rfc][:items_import].original_filename) # open spreadsheet
    headers = data.row(1) # get header row
    data.each_with_index do |row, idx|
      next if idx == 0 # skip header
      # create hash from headers and cells
      user_data = Hash[[headers, row].transpose]
      if !Aplikasi.exists?(nama_aplikasi: user_data['NAMA_APLIKASI'])
        brand = Aplikasi.new
        brand.id_aplikasi = user_data['ID_APLIKASI']
        brand.kode = user_data['KODE']
        brand.nama_aplikasi = user_data['NAMA_APLIKASI']
        brand.deskripsi = user_data['DESKRIPSI']
        brand.pemilik_proses = user_data['PEMILIK_PROSES']
        brand.save!
      end
      #Filter import master Data
      
      if !Rfc.exists?(no_registrasi_perubahan: user_data['NO_REGISTRASI_PERUBAHAN'])
        rfc = Rfc.new
        rfc.no_registrasi_perubahan = user_data['NO_REGISTRASI_PERUBAHAN']
        rfc.save!
      end

      
    end
    redirect_back(fallback_location: root_path)
  end

  def update
  end

  def destroy
  end
end