prawn_document do |pdf|

    pdf.font "Helvetica", :size => 8
    pdf.text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
    pdf.text "Listado de red - #{@network.name}", :size => 14

    pdf.text "Nombre de red: #{@network.name}"
    pdf.text "Dirección de red: #{@network}"
    pdf.text "Broadcast: #{@network.broadcast}"
    pdf.text "Puerta de enlace: #{@network.gw}"
    pdf.text "VLAN: #{@network.vlan}"

    pdf.move_down 25

    data = Array.new

    data.push ["IP","Nombre de host","Descripción"]

    @network.sips.each {|ip|
    data.push [
      ip.ip,
      ip.hostname,
      ip.label ] if ip.assigned
    }

    pdf.table data,
        :header => true,
        :row_colors => [ "f0f0f0", "ffffff" ]
end
