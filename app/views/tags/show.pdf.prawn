prawn_document do |pdf|
    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Etiqueta #{@tag}", :size => 14
    pdf.text @tag.description, :size => 10 if @tag.description != nil
    pdf.move_down 25



    data = Array.new
    data.push ["Nombre","Descripción","Etiquetas","IP's"]

    @tag.activos.order("name").each {|a|
        data.push [ a.name,a.description,a.raw_tags_list,a.sips.length ]
    }

    pdf.font "Helvetica", :size => 8
    pdf.table data,
        :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ],
        :cell_style => { :size => 8 }

end
