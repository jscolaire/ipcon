prawn_document do |pdf|
    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Listado de vlan's", :size => 14

    data = Array.new
    data.push ["Tag", "Nombre", "Redes asociadas"]

    Vlan.order("tag").each {|v|
        data.push [ v.tag,v.name ]
    }

    pdf.table data, :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ]
end
