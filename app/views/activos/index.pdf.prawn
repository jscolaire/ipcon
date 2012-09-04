prawn_document do |pdf|
    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Listado de activos", :size => 14

    data = Array.new
    data.push ["Nombre","Descripción","Etiquetas","IP's"]

    Activo.order("name").each {|a|
        data.push [ a.name,a.description,a.raw_tags_list,a.sips.length ]
    }

    pdf.table data, :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ]
end
