class ExportAbksController < ApplicationController
  def create
      @getPersonil = MainResponsibility.find_by_staff_id(params[:staff])
      @getTanggungJawab = MainResponsibility.where('staff_id = ?', params[:staff]).select('*').order(:tanggung_jawab_utama => :asc)
      Axlsx::Package.new do |my_axlsx_package|
        my_axlsx_package.workbook do |wb|
          styles = wb.styles
          header = styles.add_style :bg_color => "000000", :fg_color=>"ffffff", :sz => 11, :b => true, :border => { :style => :thin, :color => '0000000' }, :alignment => {:horizontal => :center, :vertical=>:center, wrap_text: true}
          none_border = styles.add_style :bg_color => "000000", :fg_color=>"ffffff", :sz => 14, :border => { :style => :thin, :color => '0000000' }, :alignment => {:horizontal => :center, :vertical=>:center}
          
          ##untuk keterangan personil
          header_keterangan = styles.add_style :bg_color => "000000", :fg_color=>"ffffff", :sz => 11, :b => true, :border => { :style => :thin, :color => 'ffffff' }, :alignment => {:vertical=>:center, wrap_text: true}
          ###########################
          
          ##untuk konten
          header_content = styles.add_style :bg_color => "469fb8", :fg_color=>"ffffff", :sz => 11, :b => true, :border => { :style => :thin, :color => '0000000' }, :alignment => {:horizontal => :center, :vertical=>:center, wrap_text: true}
          ###################

          ##untuk konten
          content_index = styles.add_style :sz => 11, :border => { :style => :thin, :color => '0000000' }, :alignment => {:horizontal => :center, :vertical=>:center, wrap_text: true}
          content = styles.add_style :sz => 11, :border => { :style => :thin, :color => '0000000' },:alignment => {:vertical=>:center, wrap_text: true}
          ##################

          wb.add_worksheet(name: "1. Form Tanggung Jawab Utama") do |sheet|
            sheet.add_row ["FORM TANGGUNG JAWAB UTAMA ", "", "", "", "" , "", ""], style: [none_border, none_border, none_border, none_border, none_border, none_border, none_border]
            sheet.merge_cells "A1:G1"

            sheet.add_row ["Nama : " + @getPersonil.staff.try(:nama), "", "", "Satuan Kerja : ",  @getPersonil.staff.try(:satuan_kerja) , "", ""], style: [header_keterangan, header_keterangan, header_keterangan, header_keterangan, header_keterangan, header_keterangan, header_keterangan]
            sheet.add_row ["Jabatan : " + @getPersonil.staff.try(:jabatan), "", "", "Status Kepegawaian : " , @getPersonil.staff.try(:status_kepegawaian) , "", ""], style: [header_keterangan, header_keterangan, header_keterangan, header_keterangan, header_keterangan, header_keterangan, header_keterangan]
            sheet.merge_cells "A2:B2"
            sheet.merge_cells "A3:B3"
            sheet.merge_cells "E2:G2"
            sheet.merge_cells "E3:G3"
            
            sheet.add_row ["NO", "Tanggung Jawab Utama", "Aktivitas", "Output", "Periode", "Frekuensi" , "Menit (per 1 Frekuensi)"], style: [header_content, header_content, header_content, header_content, header_content, header_content, header_content], height: 50
            
            @getTanggungJawab.each_with_index do |responsibility, index|
              @aktivitas =   if (responsibility.aktivitas.nil? or responsibility.aktivitas.empty?) then
                                  ""
                              else
                                  responsibility.aktivitas[0, 1] == "[" ? JSON::parse(responsibility.aktivitas) : ""
                              end
              sheet.add_row [index+1, responsibility.tanggung_jawab_utama, @aktivitas.each_with_index.map{|i, index| @aktivitas.count > 1 ? "#{index+1}) " + i.to_s : "" + i.to_s}.join("\r"), responsibility.output, responsibility.periode, responsibility.frekuensi, responsibility.menit], style: [content_index, content, content, content, content_index, content_index, content_index]
            end 
            sheet.column_widths 5, 30, 40, 30, 10, 12.5, 10
          end

          # @bulan = "06"
          # @parse = Date.parse(@bulan)
          # @nama_bulan = @parse.strftime('%B')

          # abort @nama_bulan.inspect
          
          @getPerBulan = WorkActivity.where('staff_id = ? and tahun = ?', params[:staff], params[:tahun]).select('DISTINCT ON (bulan) *').order(:bulan => :asc)
          @getPerBulan.each do |bulan|
            @getNamaBulan = bulan.periode_waktu.strftime("%B")
            wb.add_worksheet(name: "Aktivitas Harian (" + @getNamaBulan + ")") do |sheet|
              sheet.add_row ["FORM AKTIVITAS", "", "", ""], style: [none_border, none_border, none_border, none_border]
              sheet.add_row ["Tanggal : " + @getNamaBulan.to_s + " " + bulan.try(:tahun).to_s, "", "", ""], style: [header_keterangan, header_keterangan, header_keterangan, header_keterangan]
              sheet.merge_cells "A1:D1"
              sheet.merge_cells "A2:B2"
              sheet.add_row ["NO", "Periode Waktu", "Aktivitas", "Waktu Per Aktivitas"], style: [header_content, header_content, header_content, header_content]
              @getFormHarian = WorkActivity.where('staff_id = ? and bulan = ?', params[:staff], bulan.bulan).select('*').order(:periode_waktu => :asc)
              @getFormHarian.each_with_index do |aplikasi, index|
                @aktivitas =    if (aplikasi.aktivitas.nil? or aplikasi.aktivitas.empty?) then
                                    ""
                                else
                                  aplikasi.aktivitas[0, 1] == "[" ? JSON::parse(aplikasi.aktivitas) : ""
                                end
                sheet.add_row [index+1, aplikasi.periode_waktu.try(:strftime, "%d %B %Y"), @aktivitas.each_with_index.map{|i, index| @aktivitas.count > 1 ? "#{index+1}) " + i.to_s : "" + i.to_s}.join("\r"), aplikasi.waktu_per_aktivitas], style: [content_index, content, content, content]
              end
              sheet.column_widths 5, 15, 40, 20
            end
          end 

        end
        send_data my_axlsx_package.to_stream.read, :filename => "ABK_" + @getPersonil.staff.try(:nama) + ".xlsx"
      end
  end
end
