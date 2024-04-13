/* [User parameters] */
powerstrip_width  = 20;
powerstrip_length = 45;
powerstrip_thickness = 1;
powerstrip_padding = 1;
powerstrip_padding_open_top = false;

/* [HSW Specific parameters] */
$fa = 8;
$fs = 0.25;
tolerance = 0;
decoration = false;
structure = [[2],[1]];
hsw_horizontal_distance_unit = 40.88;

powerstrip_block_width = powerstrip_width + powerstrip_padding * 2;
powerstrip_block_length = powerstrip_length + powerstrip_padding;

include <hws_openscad_attachments_and_connectors/hws_insert_util.scad>


module insert_plug_adv(structure)
{
    for (y_pos = [0:len(structure) - 1])
    {
        for (x_pos = [0:len(structure[y_pos]) - 1])
        {
            if (structure[y_pos][x_pos] != 0)
            {
                _draw_insert(structure, x_pos, y_pos, tolerance, decoration);
            }
        }
    }
}

union() {
    difference() {
        rotate([0, 0, 60]) insert_plug_adv(structure);
        color("Tomato") translate([-25.981/2, -lip_outer_distance/2, 0])cube([25.981, lip_outer_distance, insert_height + lip_height]);
    }
    difference() {
        translate([-powerstrip_block_length/2, -powerstrip_block_width + lip_outer_distance / 2, 0]) cube([powerstrip_block_length, powerstrip_block_width, insert_height]);
        translate([-powerstrip_block_length/2 + (powerstrip_padding_open_top ? 0 : powerstrip_padding), -powerstrip_block_width + lip_outer_distance / 2 + powerstrip_padding, insert_height - powerstrip_thickness / 2]) cube([powerstrip_length, powerstrip_width, powerstrip_thickness / 2]);
    }
}

