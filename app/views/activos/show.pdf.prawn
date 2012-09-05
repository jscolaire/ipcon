prawn_document do |pdf|
    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Activo #{@activo}", :size => 14
    pdf.text @activo.description, :size => 10 if @activo.description != nil
    pdf.move_down 25



    data = Array.new
    data.push ["IP","Nombre de host","Descripción"]

    @activo.sips.each {|i|
        data.push [ i.ip,i.hostname,i.label ]
    }

    pdf.font "Helvetica", :size => 8
    pdf.table data,
        :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ],
        :cell_style => { :size => 8 }

end

