prawn_document do |pdf|
    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Listado de etiquetas", :size => 14

    pdf.move_down 25

    data = Array.new
    data.push ["Etiqueta","Descripción","Nº activos"]

    Tag.order("tag").each {|t|
        data.push [ t.tag,t.description,t.activos.length ]
    }

    pdf.font "Helvetica", :size => 8
    pdf.table data,
        :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ],
        :cell_style => { :size => 8 }

end
