prawn_document do |pdf|

    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Listado de redes", :size => 14

    pdf.move_down 25

    data = Array.new
    data.push [ "Red","Nombre", "VLAN" ]
    @networks.each {|net|
        if net.vlan
            vlan = net.vlan.to_s
        else
            vlan = ""
        end
        data.push [ net.prefix,net.name, vlan ]
    }

    pdf.font "Helvetica", :size => 8
    pdf.table data,
        :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ],
        :cell_style => { :size => 8 }
end

