#let datum = toml("data.toml").location

#let colors = (x: rgb("#ffbcb6"), y: rgb("#b8ffb3"), z: rgb("c9fffe"))

= Lista de Portais
#{

    let south = datum.filter(x => x.radial == "S")
    south = south.sorted(key: it => (it.x, it.z))

    let north = datum.filter(x => x.radial == "N")
    north = north.sorted(key: it => (-it.x, it.z))

    let east = datum.filter(x => x.radial == "E")
    east = east.sorted(key: it  => (it.z, it.x))

    let west = datum.filter(x => x.radial == "W")
    west = west.sorted(key: it => (-it.z, it.x))


    let into_data(it) = {
         let temp = ()

        for item in it {
            temp.push(((item.x, item.y, item.z), item.at("poi_nether", default: ()).sorted().join(", "), item.at("poi_overworld", default: ()).sorted().join(", ")))
        }

        return temp
    }




  //  xs

    // Show Rule: Marca os portais não explorados em vermelho.
    let format-cells(row-cells) = {
        // Base run, put colors for XYZ
        let cells = ()

        let pos = row-cells.at(0)

        let positions = (table.cell(fill: colors.x, [#pos.at(0)]), table.cell(fill: colors.y, [#pos.at(1)]), table.cell(fill: colors.z, [#pos.at(2)]))
        let nether =   if row-cells.at(1) == none { table.cell([_N/A_])} else { table.cell([#row-cells.at(1)]) }
        let overworld = if row-cells.at(2) == none { table.cell([_N/A_])} else { table.cell([#row-cells.at(2)]) }


        let joined = positions + (nether , overworld)


        let is_empty = row-cells.at(1) == none and row-cells.at(2) == none
        if is_empty {
            joined = joined.map(x => table.cell(x, stroke: red, fill: red.lighten(70%)))
        }

        return joined
    }


    south = into_data(south).map(format-cells)
    north = into_data(north).map(format-cells)
    east = into_data(east).map(format-cells)
    west = into_data(west).map(format-cells)



    if north.len() > 0 {
        [== Gelovias: Direção Norte]
        table(
            // Pos, Radial, Overworld, Nether
            columns: 3+2,
            table.header(
                table.cell(colspan:3)[*Posição*], [*POIs Nether*], [*POIs Overworld*],
                ..north.flatten()
            )
        )
    }


    if south.len() > 0 {
     [== Gelovias: Direção Sul]
        table(
            // Pos, Radial, Overworld, Nether
            columns: 3+2,
            table.header(
                table.cell(colspan:3)[*Posição*], [*POIs Nether*], [*POIs Overworld*],
                ..south.flatten()
            )
        )
    }



    if east.len() > 0 {
        [== Gelovias: Direção Leste]
        table(
            // Pos, Radial, Overworld, Nether
            columns: 3+2,
            table.header(
                table.cell(colspan:3)[*Posição*], [*POIs Nether*], [*POIs Overworld*],
                ..east.flatten()
            )
        )
    }


   if west.len() > 0 {
        [== Gelovias: Direção Oeste]
        table(
            // Pos, Radial, Overworld, Nether
            columns: 3+2,
            table.header(
                table.cell(colspan:3)[*Posição*], [*POIs Nether*], [*POIs Overworld*],
                ..west.flatten()
            )
        )
    }
}

= Definição das Estações
