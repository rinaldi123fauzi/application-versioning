class DashboardsController < ApplicationController
  def dashboard_1
  end

  def dashboard_2
  end

  def dashboard_3
    @extra_class = "sidebar-content"
  end

  def dashboard_4
    render :layout => "layout_2"
  end

  def dashboard_4_1
  end

  def home
    if params[:min].present? and params[:max].present?
      unless params[:export]
        @filter = true
        @min = params[:min]
        @max = params[:max]
        @getRfc = Rfc.includes(:aplikasi).where('tanggal BETWEEN ? AND ? and ((status = ?) or (status = ?) or (status = ?) or (status = ?) or (status = ?))', "#{params[:min]}", "#{params[:max]}", "Open", "Waiting Quality Check", "Waiting UAT", "Waiting Release", "Closed").select('*').order(:id_status => :asc, :no_registrasi_perubahan => :asc)
        @countRfc = Rfc.order(:no_registrasi_perubahan => :desc).count
        @result = Rfc.where('tanggal BETWEEN ? AND ? and ((status = ?) or (status = ?) or (status = ?) or (status = ?) or (status = ?))', "#{params[:min]}", "#{params[:max]}", "Open", "Waiting Quality Check", "Waiting UAT", "Waiting Release", "Closed").order(:no_registrasi_perubahan => :desc).count
      else
        @getRfc = Rfc.includes(:aplikasi).where('tanggal BETWEEN ? AND ? and ((status = ?) or (status = ?) or (status = ?) or (status = ?) or (status = ?))', "#{params[:min]}", "#{params[:max]}", "Open", "Waiting Quality Check", "Waiting UAT", "Waiting Release", "Closed").select('*').order(:no_registrasi_perubahan => :asc)
        @countRfc = Rfc.includes(:aplikasi).where('tanggal BETWEEN ? AND ? and ((status = ?) or (status = ?) or (status = ?) or (status = ?) or (status = ?))', "#{params[:min]}", "#{params[:max]}", "Open", "Waiting Quality Check", "Waiting UAT", "Waiting Release", "Closed").select('*').count
        @getAplikasi = Aplikasi.all
        Axlsx::Package.new do |my_axlsx_package|
          my_axlsx_package.workbook do |wb|
            styles = wb.styles
            header = styles.add_style :bg_color => "dae1e3", :sz => 12, :b => true, :border => { :style => :thin, :color => '0000000' }, :alignment => {:horizontal => :center, :vertical=>:center, :wrap_text => true}
            none = styles.add_style :bg_color => "ffff"
            none_border = styles.add_style :bg_color => "a3caf0", :sz => 20, :alignment => {:horizontal => :center, :vertical=>:center, :wrap_text => true}
            content = styles.add_style :border => { :style => :thin, :color => '0000000' }, :sz => 12, :alignment => {:vertical=>:center, :wrap_text => true}

            wb.add_worksheet(name: "RFC") do |sheet|
              @tgl = Date.parse(@getRfc.first.try(:tanggal))
              sheet.add_row ["MANAJEMEN PERUBAHAN APLIKASI PT PGAS SOLUTION TAHUN " + @tgl.strftime("%Y"), "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "","",""], style: [none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border]
              sheet.add_row ["", "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "","",""], style: [none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border]
              sheet.add_row ["", "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "","",""], style: [none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border]
              sheet.add_row ["", "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "","",""], style: [none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border, none_border]
              sheet.add_row ["", "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "","",""]
              sheet.merge_cells "A1:Z4"
              
              sheet.add_row ["NO REGISTRASI PERUBAHAN", "ID APLIKASI", "VERSI APLIKASI", "PERMINTAAN PERUBAHAN", "", "" , "", "ANALISA PERUBAHAN", "", "", "", "PENYELESAIAN PEKERJAAN", "", "", "", "", "INTERNAL QUALTY CHECK","", "", "USER ACCEPTANCE TEST", "", "", "", "RELEASE VERSI SETELAH PERUBAHAN", "", "", "", "STATUS", "KETERANGAN"], style: [header, header, header, header, header, header, none, header, header, header, none, header, header, header, header, none, header, header, none, header, header, header, none, header, header, header, none, header,header]
              sheet.add_row ["", "", "", "URAIAN PERUBAHAN", "LINK / REF", "TANGGAL", "", "PRIORITAS", "KATEGORI", "RISIKO", "", "KODE PENYELESAIAN", "TGL.SELESAI", "DURASI", "PIC", "", "TGL.TESTING", "PENGUJI", "", "NO TESTING", "TGL.TESTING", "PENGUJI", "", "TGL.RELEASE", "PEMILIK PROSES", "VERSI SOURCECODE", "", "", ""], style: [header, header, header, header, header,header, none, header, header, header, none, header, header, header, header, none, header, header, none, header, header, header, none, header, header, header, none, header,header]
              sheet.column_widths *(sheet.column_info.map { |info| [info.width, 20].min })
              sheet.merge_cells "A5:Z5"
              sheet.merge_cells "A6:A7"
              sheet.merge_cells "B6:B7"
              sheet.merge_cells "C6:C7"
              sheet.merge_cells "D6:F6"
              sheet.merge_cells "H6:J6"
              sheet.merge_cells "L6:O6"
              sheet.merge_cells "Q6:R6"
              sheet.merge_cells "T6:V6"
              sheet.merge_cells "X6:Z6"
              sheet.merge_cells "AB6:AB7"
              sheet.merge_cells "AC6:AC7"
              @p7 = @countRfc += 8
              sheet.merge_cells "P7:P" + @p7.to_s
              sheet.merge_cells "G7:G" + @p7.to_s
              sheet.merge_cells "S7:S" + @p7.to_s
              sheet.merge_cells "K7:K" + @p7.to_s
              sheet.merge_cells "W7:W" + @p7.to_s
              sheet.merge_cells "AA7:AA" + @p7.to_s
              @getRfc.each do |rfc|
                @tgl = Date.parse(rfc.try(:tanggal))
                @penyelesaian = Penyelesaian.find_by_rfc_id(rfc.id)
                @qc = Internal.find_by_rfc_id(rfc.id)
                @uat = Uat.find_by_rfc_id(rfc.id)
                @release = Change.find_by_rfc_id(rfc.id)
                @uraian_perubahan = if (rfc.uraian_perubahan.nil? or rfc.uraian_perubahan.empty?) then
                                      ""
                                    else
                                      rfc.uraian_perubahan[0, 1] == "[" ? JSON::parse(rfc.uraian_perubahan) : ""
                                    end

                # @uraian_perubahan.each do |etc, index|
                #   @perubahan = etc
                # end

                @link = if (rfc.link.nil? or rfc.link.empty?) then
                          ""
                        else
                          rfc.link[0, 1] == "[" ? JSON::parse(rfc.link) : ""
                        end

                # @link.each do |etc, index|
                #   @link = etc
                # end

                @status_uraians = if (rfc.status_uraian.nil? or rfc.status_uraian.empty?) then
                                    ""
                                  else
                                    rfc.status_uraian[0, 1] == "[" ? JSON::parse(rfc.status_uraian) : ""
                                  end
                                    
                sheet.add_row [rfc.no_registrasi_perubahan, rfc.aplikasi.id_aplikasi, rfc.versi_aplikasi, @uraian_perubahan.each_with_index.map{|i, index| @uraian_perubahan.count > 2 ? "#{index+1}) " + i.to_s : "" + i.to_s}.join("\r"), @link.each_with_index.map{|i, index| @link.count > 2 ? "#{index+1}) " + i.to_s : "" + i.to_s}.join("\r"), @tgl.strftime("%d %B %Y"), "", rfc.priority.nama, rfc.category.nama, rfc.risiko.nama, "", @penyelesaian.try(:kode_penyelesaian), @penyelesaian ? @penyelesaian.tgl_selesai.strftime("%d %B %Y") : "", @penyelesaian.try(:durasi), @penyelesaian.try(:pic), "", @qc ? @qc.tgl_testing.strftime("%d %B %Y") : "", @qc.try(:penguji), "", @uat.try(:no_testing), @uat ? @uat.tgl_testing.strftime("%d %B %Y") : "", @uat.try(:penguji), "", @release ? @release.tgl_release.strftime("%d %B %Y") : "", @release.try(:pemilik_proses), @release.try(:versi_sourcecode), "", rfc.status, @status_uraians.each_with_index.map{|i, index| @status_uraians.count > 2 ? "#{index+1}) " + i.to_s : "" + i.to_s}.join("\r")], style: content
              end
              sheet.column_widths 30, 13, 17, 60, 60, 14, nil, 12, 12, 12, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 10
            end

            wb.add_worksheet(name: "ID Aplikasi") do |sheet|
              sheet.add_row ["ID APLIKASI", "KODE", "NAMA APLIKASI", "DESKRIPSI", "DIVISI PEMILIK PROSES" , "NAMA PEMILIK PROSES"], style: [header, header, header, header, header, header]
              @getAplikasi.each do |aplikasi|
                sheet.add_row [aplikasi.id_aplikasi, aplikasi.kode, aplikasi.nama_aplikasi, aplikasi.deskripsi, aplikasi.try(:divisi), aplikasi.try(:pemilik_proses)], style: content
              end
              sheet.column_widths 12, 10, 25, 25, 25, 25
            end

          end
          send_data my_axlsx_package.to_stream.read, :filename => "rfc_" + params[:min] + "_sd_" + params[:max] + ".xlsx"
        end
      end 
    else
      @getRfc = Rfc.includes(:aplikasi).where('(status = ?) or (status = ?) or (status = ?) or (status = ?) or (status = ?)', "Open", "Waiting Quality Check", "Waiting UAT", "Waiting Release", "Closed").select('*').order(:id_status => :asc, :no_registrasi_perubahan => :desc).limit(10)
      @countRfc = Rfc.order(:no_registrasi_perubahan => :desc).count
      @result = 10
    end
  end
end
