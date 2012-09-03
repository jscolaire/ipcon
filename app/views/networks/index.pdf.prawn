prawn_document do |pdf|

    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Listado de redes", :size => 14

    pdf.move_down 25

    data = Array.new
    data.push [ "Red","Nombre" ]
    @networks.each {|net|
        data.push [ net.prefix,net.name ]
    }

    header = %w["Red", "Nombre"]

    pdf.font "Helvetica", :size => 8
    pdf.table data, :header => true
end

