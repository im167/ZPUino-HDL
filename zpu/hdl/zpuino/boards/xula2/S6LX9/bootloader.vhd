library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use ieee.numeric_std.all;

entity bootloader_dp_32 is
  port (
    CLK:              in std_logic;
    WEA:  in std_logic;
    ENA:  in std_logic;
    MASKA:    in std_logic_vector(3 downto 0);
    ADDRA:         in std_logic_vector(11 downto 2);
    DIA:        in std_logic_vector(31 downto 0);
    DOA:         out std_logic_vector(31 downto 0);
    WEB:  in std_logic;
    ENB:  in std_logic;
    ADDRB:         in std_logic_vector(11 downto 2);
    DIB:        in std_logic_vector(31 downto 0);
    MASKB:    in std_logic_vector(3 downto 0);
    DOB:         out std_logic_vector(31 downto 0)
  );
end entity bootloader_dp_32;

architecture behave of bootloader_dp_32 is

  subtype RAM_WORD is STD_LOGIC_VECTOR (31 downto 0);
  type RAM_TABLE is array (0 to 1023) of RAM_WORD;
 shared variable RAM: RAM_TABLE := RAM_TABLE'(
x"0b0b0b97",x"a1040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b97",x"c2040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fd0608",x"72830609",x"81058205",x"832b2a83",x"ffff0652",x"04000000",x"00000000",x"00000000",x"71fd0608",x"83ffff73",x"83060981",x"05820583",x"2b2b0906",x"7383ffff",x"0b0b0b0b",x"83a70400",x"72098105",x"72057373",x"09060906",x"73097306",x"070a8106",x"53510400",x"00000000",x"00000000",x"72722473",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71737109",x"71068106",x"30720a10",x"0a720a10",x"0a31050a",x"81065151",x"53510400",x"00000000",x"72722673",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"cc040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"720a722b",x"0a535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72729f06",x"0981050b",x"0b0b88af",x"05040000",x"00000000",x"00000000",x"00000000",x"00000000",x"72722aff",x"739f062a",x"0974090a",x"8106ff05",x"06075351",x"04000000",x"00000000",x"00000000",x"71715351",x"020d0406",x"73830609",x"81058205",x"832b0b2b",x"0772fc06",x"0c515104",x"00000000",x"72098105",x"72050970",x"81050906",x"0a810653",x"51040000",x"00000000",x"00000000",x"00000000",x"72098105",x"72050970",x"81050906",x"0a098106",x"53510400",x"00000000",x"00000000",x"00000000",x"71098105",x"52040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72720981",x"05055351",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097206",x"73730906",x"07535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fc0608",x"72830609",x"81058305",x"1010102a",x"81ff0652",x"04000000",x"00000000",x"00000000",x"71fc0608",x"0b0b0b9d",x"dc738306",x"10100508",x"060b0b0b",x"88b20400",x"00000000",x"00000000",x"0b0b0b89",x"80040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"e8040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097081",x"0509060a",x"8106ff05",x"70547106",x"73097274",x"05ff0506",x"07515151",x"04000000",x"72097081",x"0509060a",x"098106ff",x"05705471",x"06730972",x"7405ff05",x"06075151",x"51040000",x"05ff0504",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"810b0b0b",x"0b9ea40c",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71810552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"02840572",x"10100552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"717105ff",x"05715351",x"020d0400",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"81dd3f95",x"aa3f0400",x"00000000",x"00000000",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101053",x"51047381",x"ff067383",x"06098105",x"83051010",x"102b0772",x"fc060c51",x"51043c04",x"72728072",x"8106ff05",x"09720605",x"71105272",x"0a100a53",x"72ed3851",x"51535104",x"88088c08",x"90087575",x"98dd2d50",x"50880856",x"900c8c0c",x"880c5104",x"88088c08",x"90087575",x"98992d50",x"50880856",x"900c8c0c",x"880c5104",x"88088c08",x"90088dfc",x"2d900c8c",x"0c880c04",x"ff3d0d0b",x"0b0b9eb4",x"335170a6",x"389eb008",x"70085252",x"70802e92",x"3884129e",x"b00c702d",x"9eb00870",x"08525270",x"f038810b",x"0b0b0b9e",x"b434833d",x"0d040480",x"3d0d0b0b",x"0b9ee008",x"802e8e38",x"0b0b0b0b",x"800b802e",x"09810685",x"38823d0d",x"040b0b0b",x"9ee0510b",x"0b0bf5f8",x"3f823d0d",x"0404ff3d",x"0d80c480",x"80845271",x"0870822a",x"70810651",x"515170f3",x"38833d0d",x"04ff3d0d",x"80c48080",x"84527108",x"70812a70",x"81065151",x"5170f338",x"7382900a",x"0c833d0d",x"04fe3d0d",x"747080dc",x"8080880c",x"7081ff06",x"ff831154",x"51537181",x"268d3880",x"fd518aa9",x"2d72a032",x"51833972",x"518aa92d",x"843d0d04",x"803d0d83",x"ffff0b83",x"d00a0c80",x"fe518aa9",x"2d823d0d",x"04ff3d0d",x"83d00a08",x"70882a52",x"528ac92d",x"7181ff06",x"518ac92d",x"80fe518a",x"a92d833d",x"0d0482f6",x"ff0b80cc",x"8080880c",x"800b80cc",x"8080840c",x"9f0b8390",x"0a0c04ff",x"3d0d7370",x"08515180",x"c8808084",x"70087081",x"07720c52",x"52833d0d",x"04ff3d0d",x"80c88080",x"84700870",x"fe06720c",x"5252833d",x"0d04a090",x"0ba0800c",x"9eb80ba0",x"840c97ba",x"2dff3d0d",x"73518b71",x"0c901152",x"98808072",x"0c80720c",x"700883ff",x"ff06880c",x"833d0d04",x"fa3d0d78",x"7a7dff1e",x"57575853",x"73ff2ea7",x"38805684",x"5275730c",x"72088818",x"0cff1252",x"71f33874",x"84167408",x"720cff16",x"56565273",x"ff2e0981",x"06dd3888",x"3d0d04f8",x"3d0d80d0",x"80808457",x"83d00a59",x"8be12d76",x"518c852d",x"9eb87088",x"08101098",x"80840571",x"70840553",x"0c5656fb",x"8084a1ad",x"750c9e94",x"0b88170c",x"8070780c",x"770c7608",x"83ffff06",x"568fffdf",x"800b8808",x"278338ff",x"3983ffff",x"790ca080",x"54880853",x"78527651",x"8ca42d76",x"518bc72d",x"78085574",x"762e8938",x"80c3518a",x"a92dff39",x"a0840855",x"74fbb084",x"b2802e89",x"3880c251",x"8aa92dff",x"3980d00a",x"700870ff",x"bf06720c",x"56568a8e",x"2d8bf62d",x"ff3d0d9e",x"c4088111",x"9ec40c51",x"83900a70",x"0870feff",x"06720c52",x"52833d0d",x"04803d0d",x"8af82d72",x"81800751",x"8ac92d8b",x"8d2d823d",x"0d04fe3d",x"0d80d080",x"8084538b",x"e12d8573",x"0c80730c",x"72087081",x"ff067453",x"51528bc7",x"2d71880c",x"843d0d04",x"fc3d0d76",x"81113382",x"12337181",x"800a2971",x"84808029",x"05831433",x"70828029",x"12841633",x"527105a0",x"80058616",x"85173357",x"52535355",x"575553ff",x"135372ff",x"2e913873",x"70810555",x"33527175",x"70810557",x"34e93989",x"518e992d",x"863d0d04",x"f93d0d79",x"5780d080",x"8084568b",x"e12d8117",x"33821833",x"71828029",x"05535371",x"802e9438",x"85177255",x"53727081",x"05543376",x"0cff1454",x"73f33883",x"17338418",x"33718280",x"29055652",x"80547375",x"27973873",x"5877760c",x"73177608",x"53537173",x"34811454",x"747426ed",x"3875518b",x"c72d8af8",x"2d818451",x"8ac92d74",x"882a518a",x"c92d7451",x"8ac92d80",x"54737527",x"8f387317",x"70335252",x"8ac92d81",x"1454ee39",x"8b8d2d89",x"3d0d0404",x"fc3d0d76",x"81113382",x"12337190",x"2b71882b",x"07831433",x"70720788",x"2b841633",x"71075152",x"53575754",x"5288518e",x"992d81ff",x"518aa92d",x"80c48080",x"84537208",x"70812a70",x"81065151",x"5271f338",x"73848080",x"0780c480",x"80840c86",x"3d0d04fe",x"3d0d8eae",x"2d880888",x"08810653",x"5371f338",x"8af82d81",x"83518ac9",x"2d72518a",x"c92d8b8d",x"2d843d0d",x"04fe3d0d",x"800b9ec4",x"0c8af82d",x"8181518a",x"c92d9e94",x"538f5272",x"70810554",x"33518ac9",x"2dff1252",x"71ff2e09",x"8106ec38",x"8b8d2d84",x"3d0d04fe",x"3d0d800b",x"9ec40c8a",x"f82d8182",x"518ac92d",x"80d08080",x"84528be1",x"2d81f90a",x"0b80d080",x"809c0c71",x"08725253",x"8bc72d72",x"9ecc0c72",x"902a518a",x"c92d9ecc",x"08882a51",x"8ac92d9e",x"cc08518a",x"c92d8eae",x"2d880851",x"8ac92d8b",x"8d2d843d",x"0d04803d",x"0d810b9e",x"c80c800b",x"83900a0c",x"85518e99",x"2d823d0d",x"04803d0d",x"800b9ec8",x"0c8bae2d",x"86518e99",x"2d823d0d",x"04fd3d0d",x"80d08080",x"84548a51",x"8e992d8b",x"e12d9eb8",x"7452538c",x"852d7288",x"08101098",x"80840571",x"70840553",x"0c52fb80",x"84a1ad72",x"0c9e940b",x"88140c73",x"518bc72d",x"8a8e2d8b",x"f62dfc3d",x"0d80d080",x"80847052",x"558bc72d",x"8be12d8b",x"750c7680",x"d0808094",x"0c80750c",x"a0805477",x"5383d00a",x"5274518c",x"a42d7451",x"8bc72d8a",x"8e2d8bf6",x"2dffab3d",x"0d800b9e",x"c80c800b",x"9ec40c80",x"0b8dfc0b",x"a0800c57",x"80c48080",x"84568480",x"b3760c80",x"c88080a4",x"54fe7408",x"70720676",x"0c535580",x"c8808094",x"70087077",x"06720c53",x"53fd7408",x"70720676",x"0c537308",x"70720675",x"0c535580",x"c8808084",x"70087082",x"07720c53",x"53a87099",x"95717084",x"05530c99",x"f2710c53",x"9b8b0b88",x"120c9c9a",x"0b8c120c",x"93aa0b90",x"120c5388",x"0b80c080",x"80840c90",x"0a538173",x"0c8bae2d",x"fe88880b",x"80dc8080",x"840c81f2",x"0b80d00a",x"0c80d080",x"80847052",x"528bc72d",x"8be12d71",x"518bc72d",x"76777775",x"933d4141",x"5b5b5b83",x"d00a5c78",x"08708106",x"5152719d",x"389ec808",x"5372f038",x"9ec40852",x"87e87227",x"e638727e",x"0c728390",x"0a0c97b2",x"2d82900a",x"08537980",x"2e81b438",x"7280fe2e",x"09810680",x"f4387680",x"2ec13880",x"7d785856",x"5a827727",x"ffb53883",x"ffff7c0c",x"79fe1853",x"53797227",x"983880dc",x"80808872",x"55587215",x"7033790c",x"52811353",x"737326f2",x"38ff1675",x"11547505",x"ff057033",x"74337072",x"882b077f",x"08535155",x"51527173",x"2e098106",x"feed3874",x"3353728a",x"26fee438",x"7210109d",x"e8057552",x"70085152",x"712dfed3",x"397280fd",x"2e098106",x"8638815b",x"fec53976",x"829f269e",x"387a802e",x"87388073",x"a032545b",x"80d73d77",x"05fde005",x"52727234",x"811757fe",x"a239805a",x"fe9d3972",x"80fe2e09",x"8106fe93",x"387957ff",x"7c0c8177",x"5c5afe87",x"39ff3d0d",x"97ed2d80",x"52805193",x"e12d833d",x"0d048fff",x"fff80d8c",x"df048fff",x"fff80da0",x"88048808",x"80c08080",x"8808a080",x"082d5088",x"0c810b90",x"0a0c0400",x"00000000",x"00000000",x"820b80c0",x"8080900c",x"0b0b0b04",x"0083f00a",x"0b800ba0",x"80721208",x"720c8412",x"5271712e",x"ff05f238",x"028c050d",x"97e00400",x"00000000",x"00000000",x"00000000",x"00fb3d0d",x"77795555",x"80567575",x"24ab3880",x"74249d38",x"80537352",x"745180e1",x"3f880854",x"75802e85",x"38880830",x"5473880c",x"873d0d04",x"73307681",x"325754dc",x"39743055",x"81567380",x"25d238ec",x"39fa3d0d",x"787a5755",x"80577675",x"24a43875",x"9f2c5481",x"53757432",x"74315274",x"519b3f88",x"08547680",x"2e853888",x"08305473",x"880c883d",x"0d047430",x"558157d7",x"39fc3d0d",x"76785354",x"81538074",x"73265255",x"72802e98",x"3870802e",x"a9388072",x"24a43871",x"10731075",x"72265354",x"5272ea38",x"73517883",x"38745170",x"880c863d",x"0d047281",x"2a72812a",x"53537280",x"2ee63871",x"7426ef38",x"73723175",x"74077481",x"2a74812a",x"55555654",x"e539fc3d",x"0d767079",x"7b555555",x"558f7227",x"8c387275",x"07830651",x"70802ea7",x"38ff1252",x"71ff2e98",x"38727081",x"05543374",x"70810556",x"34ff1252",x"71ff2e09",x"8106ea38",x"74880c86",x"3d0d0474",x"51727084",x"05540871",x"70840553",x"0c727084",x"05540871",x"70840553",x"0c727084",x"05540871",x"70840553",x"0c727084",x"05540871",x"70840553",x"0cf01252",x"718f26c9",x"38837227",x"95387270",x"84055408",x"71708405",x"530cfc12",x"52718326",x"ed387054",x"ff8339fc",x"3d0d7679",x"71028c05",x"9f053357",x"55535583",x"72278a38",x"74830651",x"70802ea2",x"38ff1252",x"71ff2e93",x"38737370",x"81055534",x"ff125271",x"ff2e0981",x"06ef3874",x"880c863d",x"0d047474",x"882b7507",x"7071902b",x"07515451",x"8f7227a5",x"38727170",x"8405530c",x"72717084",x"05530c72",x"71708405",x"530c7271",x"70840553",x"0cf01252",x"718f26dd",x"38837227",x"90387271",x"70840553",x"0cfc1252",x"718326f2",x"387053ff",x"9039fb3d",x"0d777970",x"72078306",x"53545270",x"93387173",x"73085456",x"54717308",x"2e80c438",x"73755452",x"71337081",x"ff065254",x"70802e9d",x"38723355",x"70752e09",x"81069538",x"81128114",x"71337081",x"ff065456",x"545270e5",x"38723355",x"7381ff06",x"7581ff06",x"71713188",x"0c525287",x"3d0d0471",x"0970f7fb",x"fdff1406",x"70f88482",x"81800651",x"51517097",x"38841484",x"16710854",x"56547175",x"082edc38",x"73755452",x"ff963980",x"0b880c87",x"3d0d04ff",x"3d0d9ed4",x"0bfc0570",x"08525270",x"ff2e9138",x"702dfc12",x"70085252",x"70ff2e09",x"8106f138",x"833d0d04",x"04ebd13f",x"04000000",x"00ffffff",x"ff00ffff",x"ffff00ff",x"ffffff00",x"000008b5",x"000008e7",x"0000088f",x"000007a8",x"0000093e",x"00000955",x"0000083b",x"0000083c",x"00000754",x"00000969",x"01090600",x"00ffef80",x"05b8d800",x"b6011900",x"00000000",x"00000000",x"00000000",x"00000f5c",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"ffffffff",x"00000000",x"ffffffff",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000");

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if ENA='1' then
        if WEA='1' then
          RAM(conv_integer(ADDRA) ) := DIA;
        end if;
        DOA <= RAM(conv_integer(ADDRA)) ;
      end if;
    end if;
  end process;  

  process (clk)
  begin
    if rising_edge(clk) then
      if ENB='1' then
        if WEB='1' then
          RAM( conv_integer(ADDRB) ) := DIB;
        end if;
        DOB <= RAM(conv_integer(ADDRB)) ;
      end if;
    end if;
  end process;  
end behave;