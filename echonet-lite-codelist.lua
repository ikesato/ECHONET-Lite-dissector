-- ########################################################
-- ECHONET Lite Wireshark dissector
-- ########################################################
--
--   Author : Yuki MIZUNO
--   Version: 1.2.0
--   License: MIT
--
-- ########################################################
--
--  Copyright (c) 2016 Yuki MIZUNO
--  This software is released under the MIT License.
--  http://opensource.org/licenses/MIT
--

local list = {}

-- ========================================================
-- ECHONET Lite code list
-- ========================================================

list.esv = {
    [0x60] = "SetI",
    [0x61] = "SetC",
    [0x62] = "Get",
    [0x63] = "INF_REQ",
    [0x6E] = "SetGet",
    [0x71] = "Set_Res",
    [0x72] = "Get_Res",
    [0x73] = "INF",
    [0x74] = "INFC",
    [0x7A] = "INFC_Res",
    [0x7E] = "SetGet_Res",
    [0x50] = "SetI_SNA",
    [0x51] = "SetC_SNA",
    [0x52] = "Get_SNA",
    [0x53] = "INF_SNA",
    [0x5E] = "SetGet_SNA"
}

list.group = {
    [0x00] = "Sensor-related device",
    [0x01] = "Air Conditioner-related device",
    [0x02] = "Housing/Facilities-related device",
    [0x03] = "Cooking/Household-related device",
    [0x04] = "Health-related device",
    [0x05] = "Management/Operation-related device",
    [0x06] = "Audiovisual-related device",
    [0x0E] = "Profile object"
}


list.class = {
    [0x00] = {
        [0x01] = "Gas leak sensor",
        [0x02] = "Crime prevention sensor",
        [0x03] = "Emergency button",
        [0x04] = "First-aid sensor",
        [0x05] = "Earthquake sensor",
        [0x06] = "Electric leak sensor",
        [0x07] = "Human detection sensor",
        [0x08] = "Visitor sensor",
        [0x09] = "Call sensor",
        [0x0A] = "Condensation sensor",
        [0x0B] = "Air pollution sensor",
        [0x0C] = "Oxygen sensor",
        [0x0D] = "Illuminance sensor",
        [0x0E] = "Sound sensor",
        [0x0F] = "Mailing sensor",
        [0x10] = "Weight sensor",
        [0x11] = "Temperature sensor",
        [0x12] = "Humidity sensor",
        [0x13] = "Rain sensor",
        [0x14] = "Water level sensor",
        [0x15] = "Bath water level sensor",
        [0x16] = "Bath heating status sensor",
        [0x17] = "Water leak sensor",
        [0x18] = "Water overflow sensor",
        [0x19] = "Fire sensor",
        [0x1A] = "Cigarette smoke sensor",
        [0x1B] = "CO2 sensor",
        [0x1C] = "Gas sensor",
        [0x1D] = "VOC sensor",
        [0x1E] = "Differential pressure sensor",
        [0x1F] = "Air speed sensor",
        [0x20] = "Odor sensor",
        [0x21] = "Flame sensor",
        [0x22] = "Electric energy sensor",
        [0x23] = "Current value sensor",
        [0x24] = "Daylight sensor",
        [0x25] = "Water flow rate sensor",
        [0x26] = "Micromotion sensor",
        [0x27] = "Passage sensor",
        [0x28] = "Bed presence sensor",
        [0x29] = "Open/close sensor",
        [0x2A] = "Activity amount sensor",
        [0x2B] = "Human body location sensor",
        [0x2C] = "Snow sensor",
        [0x2D] = "Air pressure sensor"
    },
    [0x01] = {
        [0x30] = "Home air conditioner",
        [0x31] = "Cold blaster",
        [0x32] = "Electric fan",
        [0x33] = "Ventilation fan",
        [0x34] = "Air conditioner ventilation fan",
        [0x35] = "Air cleaner",
        [0x36] = "Cold blast fan",
        [0x37] = "Circulator",
        [0x38] = "Dehumidifier",
        [0x39] = "Humidifier",
        [0x3A] = "Ceiling fan",
        [0x3B] = "Electric Kotatsu",
        [0x3C] = "Electric heating pad",
        [0x3D] = "Electric blanket",
        [0x3E] = "Space heater",
        [0x3F] = "Panel heater",
        [0x40] = "Electric carpet",
        [0x41] = "Floor heater",
        [0x42] = "Electric heater",
        [0x43] = "Fan heater",
        [0x44] = "Battery charger",
        [0x45] = "Package-type commercial air conditioner (indoor unit)",
        [0x46] = "Package-type commercial air conditioner (outdoor unit)",
        [0x47] = "Package-type commercial air conditioner thermal storage unit",
        [0x48] = "Commercial fan coil unit",
        [0x49] = "Commercial air conditioning cold source (chiller)",
        [0x50] = "Commercial air conditioning hot source (boiler)",
        [0x51] = "Air-conditioning VAV for commercial applications",
        [0x52] = "Air handling unit (air-conditioning) for commercial applications",
        [0x53] = "Unit-cooler",
        [0x54] = "Condensing unit for commercial applications",
        [0x55] = "Electric storage heater"
    },
    [0x02] = {
        [0x60] = "Electrically operated blind/shade",
        [0x61] = "Electrically operated shutter",
        [0x62] = "Electrically operated curtain",
        [0x63] = "Electrically operated rain sliding door/shutter",
        [0x64] = "Electrically operated gate",
        [0x65] = "Electrically operated window",
        [0x66] = "Automatically operated entrance door/sliding door",
        [0x67] = "Garden sprinkler",
        [0x68] = "Fire sprinkler",
        [0x69] = "Fountain",
        [0x6A] = "Instantaneous water heater",
        [0x6B] = "Electric water heater",
        [0x6C] = "Solar water heater",
        [0x6D] = "Circulation pump",
        [0x6E] = "Bidet-equipped toilet (with electrically warmed seat)",
        [0x6F] = "Electric lock",
        [0x70] = "Gas line valve",
        [0x71] = "Home sauna",
        [0x72] = "Hot water generator",
        [0x73] = "Bathroom dryer",
        [0x74] = "Home elevator",
        [0x75] = "Electrically operated room divider",
        [0x76] = "Horizontal transfer",
        [0x77] = "Electrically operated clothes-drying pole",
        [0x78] = "Septic tank",
        [0x79] = "Home solar power generation ",
        [0x7A] = "Cold/hot water heat source equipment",
        [0x7B] = "Floor heater",
        [0x7C] = "Fuel cell",
        [0x7D] = "Storage battery",
        [0x7E] = "Electric vehicle charger/discharger",
        [0x7F] = "Engine cogeneration",
        [0x80] = "Electric energy meter",
        [0x81] = "Water flow meter",
        [0x82] = "Gas meter",
        [0x83] = "LP gas meter",
        [0x84] = "Clock",
        [0x85] = "Automatic door",
        [0x86] = "Commercial elevator",
        [0x87] = "Distribution panel metering",
        [0x88] = "Low voltage smart electric energy meter",
        [0x89] = "Smart gas meter",
        [0x8A] = "High voltage smart electric energy meter",
        [0x8B] = "Kerosene oil meter",
        [0x8C] = "Smart kerosene oil meter",
        [0x90] = "General lighting class",
        [0x91] = "Single function lighting",
        [0x99] = "Emergency lighting",
        [0x9D] = "Equipment light",
        [0xA0] = "Buzzer",
        [0xA2] = "Household small wind turbine power generation class"
    },
    [0x03] = {
        [0xB0] = "Coffee machine",
        [0xB1] = "Coffee mill",
        [0xB2] = "Electric hot water pot (Electric thermos)",
        [0xB3] = "Electric stove",
        [0xB4] = "Toaster",
        [0xB5] = "Juicer, food mixer",
        [0xB6] = "Food processor",
        [0xB7] = "Refrigerator",
        [0xB8] = "Combination microwave oven(Electronic oven)",
        [0xB9] = "Cooking heater",
        [0xBA] = "Oven",
        [0xBB] = "Rice cooker",
        [0xBC] = "Electronic jar",
        [0xBD] = "Dish washer",
        [0xBE] = "Dish dryer",
        [0xBF] = "Electric rice card cooker",
        [0xC0] = "Keep-warm machine",
        [0xC1] = "Rice mill",
        [0xC2] = "Automatic bread cooker",
        [0xC3] = "Slow cooker",
        [0xC4] = "Electric pickles cooker",
        [0xC5] = "Washing machine",
        [0xC6] = "Clothes dryer",
        [0xC7] = "Electric iron",
        [0xC8] = "Trouser press",
        [0xC9] = "Futon dryer",
        [0xCA] = "Small article, shoes dryer",
        [0xCB] = "Electric vacuum cleaner (including central vacuum cleaner)",
        [0xCC] = "Disposer",
        [0xCD] = "Electric mosquito catcher",
        [0xCE] = "Commercial show case",
        [0xCF] = "Commercial refrigerator",
        [0xD0] = "Commercial hot case",
        [0xD1] = "Commercial fryer",
        [0xD2] = "Commercial microwave oven",
        [0xD3] = "Washer and dryer",
        [0xD4] = "Commercial show case outdoor unit"
    },
    [0x04] = {
        [0x01] = "Weighing machine",
        [0x02] = "Clinical thermometer",
        [0x03] = "Blood pressure meter",
        [0x04] = "Blood sugar meter",
        [0x05] = "Body fat meter"
    },
    [0x05] = {
        [0xFC] = "Secure communication shared key setup node",
        [0xFD] = "Switch (supporting JEM-A/HA terminals)",
        [0xFE] = "Portable (mobile) terminal",
        [0xFF] = "Controller"
    },
    [0x06] = {
        [0x01] = "Display",
        [0x02] = "Television",
        [0x03] = "Audio",
        [0x04] = "Network camera"
    },
    [0x0E] = {
        [0xF0] = "Node profile"
    }
}


return list
