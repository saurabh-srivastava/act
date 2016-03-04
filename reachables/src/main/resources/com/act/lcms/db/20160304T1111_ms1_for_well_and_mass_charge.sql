-- Delete all rows from the ms1_for_well_and_mass_charge table
-- Delete the ion_mass_charge column since we do not want to have a decimal type as an index
-- Alter the type of the metlin_ions column from bytea to text since we are storing a list instead of a byte version
-- of a map.
-- Add a chemical_name column which can derive the ion_mass_charge for us.
DELETE FROM ms1_for_well_and_mass_charge;
DROP INDEX idx_ms1_for_well_with_scan_file_metlin_ions;
ALTER TABLE ms1_for_well_and_mass_charge DROP ion_mass_charge;
ALTER TABLE ms1_for_well_and_mass_charge ALTER metlin_ions TYPE text;
ALTER TABLE ms1_for_well_and_mass_charge ALTER metlin_ions SET NOT NULL;
ALTER TABLE ms1_for_well_and_mass_charge ADD chemical_name text NOT NULL;
CREATE UNIQUE INDEX idx_ms1_for_well_with_scan_file_metlin_ions ON ms1_for_well_and_mass_charge(plate_id, plate_row, plate_column, use_snr, scan_file, chemical_name, metlin_ions);