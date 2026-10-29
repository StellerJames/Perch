-- Day 9: add phonetic pronunciations from 'Updated MySQL Bird Data' (for the future pronunciation tool).
-- Step 1: new column for how to say the common name (latin_pronunciation already exists).
ALTER TABLE birds ADD COLUMN common_pronunciation VARCHAR(150) NULL AFTER common_name;

-- Step 2: fill both pronunciation columns. Each bird is matched by latin_name, which is unique.
START TRANSACTION;
UPDATE birds SET common_pronunciation = 'KA-nuh-duh goos', latin_pronunciation = 'BRAHN-tuh kan-uh-DEN-sis' WHERE latin_name = 'Branta canadensis';  -- Canada Goose
UPDATE birds SET common_pronunciation = 'MAL-erd', latin_pronunciation = 'ah-nahs plah-tee-RING-kōs' WHERE latin_name = 'Anas platyrhynchos';  -- Mallard
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin WYT PEL-i-kuhn', latin_pronunciation = 'peli-kanuhs ehr-rith-ror-inchohz' WHERE latin_name = 'Pelecanus erythrorhynchos';  -- American White Pelican
UPDATE birds SET common_pronunciation = 'kil-deer', latin_pronunciation = 'cha-RAD-ree-uhs voh-SIF-uh-ruhs' WHERE latin_name = 'Charadrius vociferus';  -- Killdeer
UPDATE birds SET common_pronunciation = 'KAL-ih-FOR-nyuh guhl', latin_pronunciation = 'LAH-russ kal-ih-FOR-nih-kuss' WHERE latin_name = 'Larus californicus';  -- California Gull
UPDATE birds SET common_pronunciation = 'RING-BILD GUHL', latin_pronunciation = 'LAH-russ del-uh-wair-EN-sis' WHERE latin_name = 'Larus delawarensis';  -- Ring-billed Gull
UPDATE birds SET common_pronunciation = 'TUR-kee VUL-cher', latin_pronunciation = 'kuh-THAR-teez AW-ruh' WHERE latin_name = 'Cathartes aura';  -- Turkey Vulture
UPDATE birds SET common_pronunciation = 'RED-tayld HAWK', latin_pronunciation = 'byoo-TEE-oh juh-MAY-sen-sis' WHERE latin_name = 'Buteo jamaicensis';  -- Red-tailed Hawk
UPDATE birds SET common_pronunciation = 'ROK PIJ-un', latin_pronunciation = 'kuh-LUM-buh LIV-ee-uh' WHERE latin_name = 'Columba livia';  -- Rock Pigeon
UPDATE birds SET common_pronunciation = 'MOR-ning DUHV', latin_pronunciation = 'zuh-NAY-duh mak-ROO-ruh' WHERE latin_name = 'Zenaida macroura';  -- Mourning Dove
UPDATE birds SET common_pronunciation = 'BLAK-chind HUM-ing-burd', latin_pronunciation = 'ar-CHIL-oh-chus al-ig-ZAN-dry' WHERE latin_name = 'Archilochus alexandri';  -- Black-chinned Hummingbird
UPDATE birds SET common_pronunciation = 'BEL-tid KING-fish-er', latin_pronunciation = 'meg-uh-SER-il-ay al-SY-on' WHERE latin_name = 'Megaceryle alcyon';  -- Belted Kingfisher
UPDATE birds SET common_pronunciation = 'DOWN-ee WUD-peck-er', latin_pronunciation = 'dry-oh-BAY-teez pyoo-BES-enz' WHERE latin_name = 'Dryobates pubescens';  -- Downy Woodpecker
UPDATE birds SET common_pronunciation = 'NOR-thern FLIK-er', latin_pronunciation = 'kuh-LAP-teez aw-RAH-tus' WHERE latin_name = 'Colaptes auratus';  -- Northern Flicker
UPDATE birds SET common_pronunciation = 'WES-tern KING-burd', latin_pronunciation = 'tee-RAN-us ver-tee-KAH-lis' WHERE latin_name = 'Tyrannus verticalis';  -- Western Kingbird
UPDATE birds SET common_pronunciation = 'STEL-erz JAY', latin_pronunciation = 'SY-ah-noh-SIT-uh STEL-er-eye' WHERE latin_name = 'Cyanocitta stelleri';  -- Steller's Jay
UPDATE birds SET common_pronunciation = 'WOOD-howz SKRUB-jay', latin_pronunciation = 'af-el-oh-KOH-muh wood-HOWS-ee-eye' WHERE latin_name = 'Aphelocoma woodhouseii';  -- Woodhouse's Scrub-Jay
UPDATE birds SET common_pronunciation = 'BLAK-bild MAG-pie', latin_pronunciation = 'PY-kuh hud-SOH-nee-uh' WHERE latin_name = 'Pica hudsonia';  -- Black-billed Magpie
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin KROH', latin_pronunciation = 'KOR-vus brak-ee-RING-kos' WHERE latin_name = 'Corvus brachyrhynchos';  -- American Crow
UPDATE birds SET common_pronunciation = 'KOM-un RAY-vun', latin_pronunciation = 'KOR-vus KOR-aks' WHERE latin_name = 'Corvus corax';  -- Common Raven
UPDATE birds SET common_pronunciation = 'PIN-yun JAY', latin_pronunciation = 'jim-no-RY-nus sy-an-oh-SEF-uh-lus' WHERE latin_name = 'Gymnorhinus cyanocephalus';  -- Pinyon Jay
UPDATE birds SET common_pronunciation = 'BLAK-kapt CHIK-uh-dee', latin_pronunciation = 'poh-EE-sil ah-tri-KAP-ih-lus' WHERE latin_name = 'Poecile atricapillus';  -- Black-capped Chickadee
UPDATE birds SET common_pronunciation = 'MOUN-tin CHIK-uh-dee', latin_pronunciation = 'poh-EE-sil GAM-bel-eye' WHERE latin_name = 'Poecile gambeli';  -- Mountain Chickadee
UPDATE birds SET common_pronunciation = 'HORND LARK', latin_pronunciation = 'eh-ruh-MOF-ih-luh al-PES-tris' WHERE latin_name = 'Eremophila alpestris';  -- Horned Lark
UPDATE birds SET common_pronunciation = 'TREE SWOL-oh', latin_pronunciation = 'tak-ih-sih-NET-uh by-KUL-or' WHERE latin_name = 'Tachycineta bicolor';  -- Tree Swallow
UPDATE birds SET common_pronunciation = 'VY-uh-lit GREEN SWOL-oh', latin_pronunciation = 'tak-ih-sih-NET-uh thuh-LASS-ih-nuh' WHERE latin_name = 'Tachycineta thalassina';  -- Violet-green Swallow
UPDATE birds SET common_pronunciation = 'NOR-thern RUF-wingd SWOL-oh', latin_pronunciation = 'stel-jih-DOP-ter-iks seh-rih-PEN-is' WHERE latin_name = 'Stelgidopteryx serripennis';  -- Northern Rough-winged Swallow
UPDATE birds SET common_pronunciation = 'BARN SWOL-oh', latin_pronunciation = 'hih-RUN-doh RUS-tih-kuh' WHERE latin_name = 'Hirundo rustica';  -- Barn Swallow
UPDATE birds SET common_pronunciation = 'KLIF SWOL-oh', latin_pronunciation = 'pet-roh-kuh-LY-don pir-oh-NOH-tuh' WHERE latin_name = 'Petrochelidon pyrrhonota';  -- Cliff Swallow
UPDATE birds SET common_pronunciation = 'ROO-bee-KROWND KING-let', latin_pronunciation = 'kor-THIL-ee-oh kuh-LEN-jew-luh' WHERE latin_name = 'Corthylio calendula';  -- Ruby-crowned Kinglet
UPDATE birds SET common_pronunciation = 'RED-BREST-ed NUHT-hach', latin_pronunciation = 'SIT-uh kan-uh-DEN-sis' WHERE latin_name = 'Sitta canadensis';  -- Red-breasted Nuthatch
UPDATE birds SET common_pronunciation = 'BROWN KREE-per', latin_pronunciation = 'SER-thee-uh uh-mer-ih-KAH-nuh' WHERE latin_name = 'Certhia americana';  -- Brown Creeper
UPDATE birds SET common_pronunciation = 'MARSH REN', latin_pronunciation = 'sis-toh-THOR-us puh-LUS-tris' WHERE latin_name = 'Cistothorus palustris';  -- Marsh Wren
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin ROB-in', latin_pronunciation = 'TUR-dus my-gruh-TOR-ee-us' WHERE latin_name = 'Turdus migratorius';  -- American Robin
UPDATE birds SET common_pronunciation = 'MOUN-tin BLOO-burd', latin_pronunciation = 'sy-AL-ee-uh kur-roo-KOY-deez' WHERE latin_name = 'Sialia currucoides';  -- Mountain Bluebird
UPDATE birds SET common_pronunciation = 'yur-uh-PEE-un STAR-ling', latin_pronunciation = 'STUR-nus vul-GAIR-is' WHERE latin_name = 'Sturnus vulgaris';  -- European Starling
UPDATE birds SET common_pronunciation = 'SEE-der WAX-wing', latin_pronunciation = 'bom-bih-SIL-uh seh-DROR-um' WHERE latin_name = 'Bombycilla cedrorum';  -- Cedar Waxwing
UPDATE birds SET common_pronunciation = NULL, latin_pronunciation = NULL WHERE latin_name = 'Passer domesticus';  -- House Sparrow
UPDATE birds SET common_pronunciation = 'BLOO-GRAY NAT-kach-er', latin_pronunciation = 'pol-ee-OP-til-uh see-ROO-lee-uh' WHERE latin_name = 'Polioptila caerulea';  -- Blue-gray Gnatcatcher
UPDATE birds SET common_pronunciation = 'HOWS FINCH', latin_pronunciation = 'hem-or-HOW-us mek-sih-KAY-nus' WHERE latin_name = 'Haemorhous mexicanus';  -- House Finch
UPDATE birds SET common_pronunciation = 'PYN SIS-kin', latin_pronunciation = 'SPY-nus PY-nus' WHERE latin_name = 'Spinus pinus';  -- Pine Siskin
UPDATE birds SET common_pronunciation = 'LES-er GOLD-finch', latin_pronunciation = 'SPY-nus SAL-tree-uh' WHERE latin_name = 'Spinus psaltria';  -- Lesser Goldfinch
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin GOLD-finch', latin_pronunciation = 'SPY-nus TRIS-tis' WHERE latin_name = 'Spinus tristis';  -- American Goldfinch
UPDATE birds SET common_pronunciation = 'WYT-BREST-ed NUHT-hach', latin_pronunciation = 'SIT-uh kar-oh-lin-EN-sis' WHERE latin_name = 'Sitta carolinensis';  -- White-breasted Nuthatch
UPDATE birds SET common_pronunciation = 'KAS-inz FINCH', latin_pronunciation = 'hem-or-HOW-us kas-IN-ee-eye' WHERE latin_name = 'Haemorhous cassinii';  -- Cassin’s Finch
UPDATE birds SET common_pronunciation = 'CHIP-ing SPAR-oh', latin_pronunciation = 'spy-ZEL-uh pas-uh-RY-nuh' WHERE latin_name = 'Spizella passerina';  -- Chipping Sparrow
UPDATE birds SET common_pronunciation = 'DARK-eyed JUNG-koh', latin_pronunciation = 'JUNG-koh hy-EM-uh-lis' WHERE latin_name = 'Junco hyemalis';  -- Dark-eyed Junco
UPDATE birds SET common_pronunciation = 'WYT-KROWND SPAR-oh', latin_pronunciation = 'zon-oh-TRIK-ee-uh LOO-koh-fris' WHERE latin_name = 'Zonotrichia leucophrys';  -- White-crowned Sparrow
UPDATE birds SET common_pronunciation = 'SONG SPAR-oh', latin_pronunciation = 'mel-oh-SPY-zuh muh-LOH-dee-uh' WHERE latin_name = 'Melospiza melodia';  -- Song Sparrow
UPDATE birds SET common_pronunciation = 'SPOT-id TOW-hee', latin_pronunciation = 'pih-PY-loh mak-yuh-LAY-tus' WHERE latin_name = 'Pipilo maculatus';  -- Spotted Towhee
UPDATE birds SET common_pronunciation = 'FOKS SPAR-oh', latin_pronunciation = 'pas-uh-REL-uh il-ee-AK-uh' WHERE latin_name = 'Passerella iliaca';  -- Fox Sparrow
UPDATE birds SET common_pronunciation = 'YEL-oh-HED-id BLAK-burd', latin_pronunciation = 'zan-thoh-SEF-uh-lus zan-thoh-SEF-uh-lus' WHERE latin_name = 'Xanthocephalus xanthocephalus';  -- Yellow-headed Blackbird
UPDATE birds SET common_pronunciation = 'WES-tern MED-oh-lark', latin_pronunciation = 'stur-NEL-uh neh-GLEK-tuh' WHERE latin_name = 'Sturnella neglecta';  -- Western Meadowlark
UPDATE birds SET common_pronunciation = 'BUL-uks OR-ee-ohl', latin_pronunciation = 'IK-ter-us BUL-ock-ee-eye' WHERE latin_name = 'Icterus bullockii';  -- Bullock's Oriole
UPDATE birds SET common_pronunciation = 'RED-wingd BLAK-burd', latin_pronunciation = 'aj-uh-LAY-us fen-ih-SEE-us' WHERE latin_name = 'Agelaius phoeniceus';  -- Red-winged Blackbird
UPDATE birds SET common_pronunciation = 'BROO-erz BLAK-burd', latin_pronunciation = 'yoo-FAY-gus sy-an-oh-SEF-uh-lus' WHERE latin_name = 'Euphagus cyanocephalus';  -- Brewer's Blackbird
UPDATE birds SET common_pronunciation = 'BROWN-HED-id KOW-burd', latin_pronunciation = 'MOL-oh-thrus AY-ter' WHERE latin_name = 'Molothrus ater';  -- Brown-headed Cowbird
UPDATE birds SET common_pronunciation = 'NOR-thern YEL-oh WOR-bler', latin_pronunciation = 'seh-TOF-uh-guh es-TY-vuh' WHERE latin_name = 'Setophaga aestiva';  -- Northern Yellow Warbler
UPDATE birds SET common_pronunciation = 'YEL-oh-RUMPT WOR-bler', latin_pronunciation = 'seh-TOF-uh-guh kor-oh-NAY-tuh' WHERE latin_name = 'Setophaga coronata';  -- Yellow-rumped Warbler
UPDATE birds SET common_pronunciation = 'lah-ZOO-lee BUN-ting', latin_pronunciation = 'pas-uh-RY-nuh uh-MEE-nuh' WHERE latin_name = 'Passerina amoena';  -- Lazuli Bunting
UPDATE birds SET common_pronunciation = 'WES-tern TAN-uh-jer', latin_pronunciation = 'pih-RANG-guh loo-doh-vis-ee-AN-uh' WHERE latin_name = 'Piranga ludoviciana';  -- Western Tanager
UPDATE birds SET common_pronunciation = 'BLAK-HED-id GROHS-beek', latin_pronunciation = 'FYOO-tik-us mel-uh-noh-SEF-uh-lus' WHERE latin_name = 'Pheucticus melanocephalus';  -- Black-headed Grosbeak
UPDATE birds SET common_pronunciation = 'KOM-un YEL-oh-throht', latin_pronunciation = 'jee-oh-THLIP-is TRY-kas' WHERE latin_name = 'Geothlypis trichas';  -- Common Yellowthroat
UPDATE birds SET common_pronunciation = 'WIL-sonz WOR-bler', latin_pronunciation = 'kar-deh-LY-nuh pyoo-SIL-uh' WHERE latin_name = 'Cardellina pusilla';  -- Wilson’s Warbler
UPDATE birds SET common_pronunciation = 'OR-inj-KROWND WOR-bler', latin_pronunciation = 'y-oh-THLIP-is seh-LAH-tuh' WHERE latin_name = 'Leiothlypis celata';  -- Orange Crowned Warbler
UPDATE birds SET common_pronunciation = 'muh-GIL-uh-vrayz WOR-bler', latin_pronunciation = 'jee-oh-THLIP-is TOL-mee-eye' WHERE latin_name = 'Geothlypis tolmiei';  -- MacGillivray’s Warbler
UPDATE birds SET common_pronunciation = 'GRAY-KROWND ROH-zee-FINCH', latin_pronunciation = 'loo-koh-STIK-tee teh-froh-KOH-tis' WHERE latin_name = 'Leucosticte tephrocotis';  -- Gray-crowned Rosy-Finch
UPDATE birds SET common_pronunciation = 'WES-tern WUD-pee-wee', latin_pronunciation = 'kon-TOH-pus sor-DID-juh-lus' WHERE latin_name = 'Contopus sordidulus';  -- Western Wood-Pewee
UPDATE birds SET common_pronunciation = 'BRAWD-TAYLD HUM-ing-burd', latin_pronunciation = 'seh-LAS-for-us plat-ih-SER-kus' WHERE latin_name = 'Selasphorus platycercus';  -- Broad-tailed Hummingbird
UPDATE birds SET common_pronunciation = 'kal-ih-FOR-nyuh KWAYL', latin_pronunciation = 'kal-ih-PEP-luh kal-ih-FOR-nih-kuh' WHERE latin_name = 'Callipepla californica';  -- California Quail
UPDATE birds SET common_pronunciation = 'KOO-perz HAWK', latin_pronunciation = 'AS-ter koo-PEER-ee-eye' WHERE latin_name = 'Astur cooperii';  -- Cooper’s Hawk
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin KES-trel', latin_pronunciation = 'FAL-koh spar-VER-ee-us' WHERE latin_name = 'Falco sparverius';  -- American Kestrel
UPDATE birds SET common_pronunciation = 'WES-tern FLY-kach-er', latin_pronunciation = 'em-pih-DOH-naks dif-ih-SIL-is' WHERE latin_name = 'Empidonax difficilis';  -- Western Flycatcher
UPDATE birds SET common_pronunciation = 'NOR-thern HAR-ee-er', latin_pronunciation = 'SIR-kus hud-SOH-nee-us' WHERE latin_name = 'Circus hudsonius';  -- Northern Harrier
UPDATE birds SET common_pronunciation = 'BAWLD EE-gul', latin_pronunciation = 'hal-ee-EE-tus loo-koh-SEF-uh-lus' WHERE latin_name = 'Haliaeetus leucocephalus';  -- Bald Eagle
UPDATE birds SET common_pronunciation = 'GOL-den EE-gul', latin_pronunciation = 'AK-wih-luh kri-SEE-tos' WHERE latin_name = 'Aquila chrysaetos';  -- Golden Eagle
UPDATE birds SET common_pronunciation = 'FRANK-linz GUL', latin_pronunciation = 'loo-koh-FEE-us pip-IKS-kan' WHERE latin_name = 'Leucophaeus pipixcan';  -- Franklin’s Gull
UPDATE birds SET common_pronunciation = 'GRAYT BLOO HER-un', latin_pronunciation = 'AR-dee-uh heh-ROH-dee-us' WHERE latin_name = 'Ardea herodias';  -- Great Blue Heron
UPDATE birds SET common_pronunciation = 'WYT-FAYST IB-is', latin_pronunciation = 'PLEG-uh-dis CHEE-hee' WHERE latin_name = 'Plegadis chihi';  -- White-faced Ibis
UPDATE birds SET common_pronunciation = 'GAD-wawl', latin_pronunciation = 'muh-REK-uh strep-ER-uh' WHERE latin_name = 'Mareca strepera';  -- Gadwall
UPDATE birds SET common_pronunciation = 'SIN-uh-mun TEEL', latin_pronunciation = 'SPAT-yoo-luh sy-an-OP-ter-uh' WHERE latin_name = 'Spatula cyanoptera';  -- Cinnamon Teal
UPDATE birds SET common_pronunciation = 'RUD-ee DUK', latin_pronunciation = 'ok-see-YOOR-uh jam-ay-SEN-sis' WHERE latin_name = 'Oxyura jamaicensis';  -- Ruddy Duck
UPDATE birds SET common_pronunciation = 'ROS-iz GOOS', latin_pronunciation = 'AN-ser ROS-ee-eye' WHERE latin_name = 'Anser rossii';  -- Ross’s Goose
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin KOOT', latin_pronunciation = 'FYOO-lih-kuh uh-mer-ih-KAH-nuh' WHERE latin_name = 'Fulica americana';  -- American Coot
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin WIJ-un', latin_pronunciation = 'muh-REK-uh uh-mer-ih-KAH-nuh' WHERE latin_name = 'Mareca americana';  -- American Wigeon
UPDATE birds SET common_pronunciation = 'GRAYT HORND OUL', latin_pronunciation = 'BYOO-boh ver-jin-ee-AY-nus' WHERE latin_name = 'Bubo virginianus';  -- Great Horned Owl
UPDATE birds SET common_pronunciation = 'KOM-un NYT-hawk', latin_pronunciation = 'kor-DY-leez MY-nor' WHERE latin_name = 'Chordeiles minor';  -- Common Nighthawk
UPDATE birds SET common_pronunciation = 'weh-surn SKREECH OUL', latin_pronunciation = 'MEG-uh-skops ken-ih-KOT-ee-eye' WHERE latin_name = 'Megascops kennicottii';  -- Western Screech Owl
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin BARN OUL', latin_pronunciation = 'TY-toh fur-KAY-tuh' WHERE latin_name = 'Tyto furcata';  -- American Barn Owl
UPDATE birds SET common_pronunciation = 'yoo-RAY-zhun KOL-erd DUHV', latin_pronunciation = 'strep-toh-PEE-lee-uh deh-KOK-toh' WHERE latin_name = 'Streptopelia decaocto';  -- Eurasian Collared Dove
UPDATE birds SET common_pronunciation = 'WYLD TUR-kee', latin_pronunciation = 'mel-ee-AG-ris gal-oh-PAY-voh' WHERE latin_name = 'Meleagris gallopavo';  -- Wild Turkey
UPDATE birds SET common_pronunciation = 'OS-pray', latin_pronunciation = 'pan-DY-on hal-ee-EE-tus' WHERE latin_name = 'Pandion haliaetus';  -- Osprey
UPDATE birds SET common_pronunciation = 'ROO-fus HUM-ing-burd', latin_pronunciation = 'seh-LAS-for-us ROO-fus' WHERE latin_name = 'Selasphorus rufus';  -- Rufous Hummingbird
UPDATE birds SET common_pronunciation = 'TOWNZ-endz SOL-ih-tair', latin_pronunciation = 'my-uh-DES-teez TOWNZ-en-dye' WHERE latin_name = 'Myadestes townsendi';  -- Townsend’s Solitaire
UPDATE birds SET common_pronunciation = 'DIP-er', latin_pronunciation = 'SING-klus mek-sih-KAY-nus' WHERE latin_name = 'Cinclus mexicanus';  -- Dipper
UPDATE birds SET common_pronunciation = 'HOWS REN', latin_pronunciation = 'troh-GLOD-ih-teez AY-don' WHERE latin_name = 'Troglodytes aedon';  -- Northern House Wren
UPDATE birds SET common_pronunciation = 'boh-HEE-mee-un WAX-wing', latin_pronunciation = 'bom-bih-SIL-uh GAR-yoo-lus' WHERE latin_name = 'Bombycilla garrulus';  -- Bohemian Waxwing
UPDATE birds SET common_pronunciation = 'IN-dih-goh BUN-ting', latin_pronunciation = 'pas-uh-RY-nuh sy-AN-ee-uh' WHERE latin_name = 'Passerina cyanea';  -- Indigo Bunting
UPDATE birds SET common_pronunciation = 'GREEN-TAYLD TOW-hee', latin_pronunciation = 'pih-PY-loh klor-OO-rus' WHERE latin_name = 'Pipilo chlorurus';  -- Green-tailed Towhee
UPDATE birds SET common_pronunciation = 'LOG-er-hed SHRYK', latin_pronunciation = 'LAN-ee-us loo-doh-vis-ee-AN-us' WHERE latin_name = 'Lanius ludovicianus';  -- Loggerhead Shrike
COMMIT;
