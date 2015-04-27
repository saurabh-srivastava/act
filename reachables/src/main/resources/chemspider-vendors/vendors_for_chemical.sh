csid=$1
# inchi=$1
# csid=`curl http://www.chemspider.com/InChI.asmx/InChIToCSID?inchi=$inchi | sed 's/^[^0-9]*\([0-9]*\)[^0-9]*$/\1/g'`
echo "Retrieving vendors for CSID = $csid"
token="b3d12bfe-1bcd-4960-a30f-ba876fe7a0fb"
# The datasrcs variable is initialized from the set of Substance_Vendors we get from Chemspider
# After step5, we do
# grep Substance_Vendors final_vendor_tagged.tsv | cut -f 2 > vendor_names.txt
# and then convert the returned names into the field below by contatenating using "datasources=<NAME>&" pattern
datasrcs="datasources=ASINEX&datasources=ChemBridge&datasources=Specs&datasources=Enamine&datasources=AKos&datasources=R%26D Chemicals&datasources=Synthon-Lab&datasources=UkrOrgSynthesis&datasources=CiVentiChem&datasources=SynChem&datasources=Ryan Scientific&datasources=TOSLab&datasources=Bio-Vin&datasources=ChemDiv&datasources=Otava Chemicals&datasources=Aronis&datasources=Life Chemicals&datasources=Calyx&datasources=Activate Scientific&datasources=Argus Chemicals&datasources=AsisChem&datasources=Boron Molecular&datasources=ChemPacific&datasources=Microsource&datasources=Trylead Chemical&datasources=Sigma-Aldrich&datasources=Afid Therapeutics&datasources=Alfa Aesar&datasources=Vitas-M&datasources=Key Organics&datasources=Matrix Scientific&datasources=PepTech&datasources=Pharmeks&datasources=Trans World Chemicals&datasources=Astatech&datasources=Chess Chemical&datasources=JRD Fluorochemicals&datasources=Ubichem&datasources=AnalytiCon Discovery&datasources=MP Biomedicals&datasources=Oakwood&datasources=Exclusive Chemistry&datasources=OmegaChem&datasources=HDH Pharma&datasources=Rieke Metals&datasources=ASDI&datasources=Florida Center for Heterocyclic Compounds&datasources=Synthonix&datasources=Shanghai Sinofluoro Scientific&datasources=Hetcat&datasources=Borochem&datasources=Biosynth&datasources=True PharmaChem&datasources=Cayman Chemical&datasources=Dipharma&datasources=ACB Blocks&datasources=Chemik&datasources=Sequoia Research Products&datasources=Apollo Scientific Limited&datasources=Spectrum Info&datasources=Infarmatik&datasources=Rudolf Boehm Institute&datasources=Timtec&datasources=Tocris Bioscience&datasources=Princeton Biomolecular&datasources=Hangzhou Sage Chemical Co., Ltd.&datasources=Viwit Pharmaceutical&datasources=MicroCombiChem&datasources=SelectLab Chemicals GmbH&datasources=Ramdev Chemicals&datasources=Extrasynthese&datasources=Gelest&datasources=Bridge Organics&datasources=Jiangsu WorldChem&datasources=Baihua Bio-Pharmaceutical&datasources=Szintekon Ltd&datasources=Excel Asia&datasources=Alinda Chemical&datasources=ennopharm&datasources=Manchester Organics&datasources=Globe Chemie&datasources=Shanghai Haoyuan Chemexpress &datasources=Shanghai Elittes organics&datasources=Cooper Chemicals&datasources=Hangzhou APIChem Technology &datasources=Mizat Chemicals &datasources=Frinton Laboratories&datasources=BePharm&datasources=HE Chemical&datasources=Molport&datasources=BioBlocks Inc.&datasources=Zerenex Molecular &datasources=Innovapharm&datasources=Research Organics&datasources=Creasyn Finechem&datasources=Alchem Pharmtech&datasources=iThemba Pharmaceuticals&datasources=Sun BioChem, Inc.&datasources=Santa Cruz Biotechnology &datasources=DSL Chemicals&datasources=AvaChem Scientific&datasources=SynQuest&datasources=Evoblocks&datasources=CDN Isotopes&datasources=Endeavour Speciality Chemicals&datasources=Shanghai Race Chemical&datasources=Shanghai IS Chemical Technology&datasources=DanYang HengAn Chemical Co.,Ltd&datasources=ChiroBlock&datasources=Platte Valley Scientific&datasources=TCI&datasources=Finetech Industry&datasources=Nagase&datasources=Annker Organics&datasources=Ark Pharm, Inc.&datasources=Aconpharm&datasources=Endotherm GmbH&datasources=InterBioScreen&datasources=Fluorochem &datasources=Accela ChemBio&datasources=ChemFuture&datasources=Syntide&datasources=Paragos&datasources=DiverChim&datasources=oriBasePharma&datasources=Chiralix&datasources=AChemo&datasources=Selleck Chemicals&datasources=Watson International Ltd&datasources=Excenen&datasources=Shanghai Boyle Chemical Co., Ltd.&datasources=Alfa Pyridines&datasources=Shanghai Excellent chemical&datasources=Chiral Quest&datasources=AMRI&datasources=Letopharm&datasources=Santai Labs&datasources=Adesis&datasources=AOKChem&datasources=Nanjing Pharmaceutical Factory Co., Ltd&datasources=DAY Biochem&datasources=zealing chem&datasources=ABI Chemicals&datasources=AOKBIO&datasources=Reddy N Reddy Pharmaceuticals&datasources=Chengdu D-innovation&datasources=Avistron Chemistry&datasources=Abacipharm&datasources=Centec&datasources=Focus Synthesis&datasources=Georganics Ltd.&datasources=Rare Chem&datasources=Annova Chem&datasources=Chicago Discovery Solutions&datasources=Solaronix&datasources=Apeiron Synthesis&datasources=Indofine&datasources=J and K Scientific&datasources=Porse Fine Chemical&datasources=Cool Pharm&datasources=Livchem&datasources=Fragmenta&datasources=AEchem Scientific&datasources=Mole-Sci.Tech&datasources=Irvine Chemistry Laboratory &datasources=Synergy-Scientific&datasources=Angene&datasources=CoachChem&datasources=Abblis Chemicals&datasources=Abcam&datasources=Jalor-Chem&datasources=AK Scientific&datasources=Acorn PharmaTech&datasources=Zylexa Pharma&datasources=Chemren Bio-Engineering&datasources=Isosep&datasources=Selleck Bio&datasources=BOC Chem&datasources=Advanced ChemBlocks&datasources=Juhua Group&datasources=Capot Chemical&datasources=LGC Standards&datasources=Biochempartner&datasources=Adooq Bioscience&datasources=Novochemy&datasources=Atomole Scientific&datasources=Huili Chem&datasources=P3 BioSystems&datasources=Beijing LYS Chemicals&datasources=Hangzhou Chempro&datasources=Abmole Bioscience&datasources=Watec Laboratories&datasources=Apexmol&datasources=Conier Chem&datasources=Amadis Chemical&datasources=Alfa Chemistry&datasources=ADVAMACS&datasources=Jupiter Sciences&datasources=Arking Pharma&datasources=Wisdom Pharma&datasources=KaironKem&datasources=Alchemist-Pharm&datasources=Natural Remedies&datasources=LeadGen Labs&datasources=Acentex Scientific&datasources=Anward&datasources=Rosewell Industry Co.&datasources=Chembo Pharma&datasources=Achemica&datasources=EDASA Scientific&datasources=Sunshine Chemlab&datasources=Acesobio&datasources=Syncozymes&datasources=Chengdu Kaixin&datasources=AminoLogics&datasources=AldLab Chemicals&datasources=ChangChem&datasources=ApexBio&datasources=BerrChem&datasources=Medchem Express&datasources=Merck Millipore&datasources=ChemScene&datasources=Glentham Life Sciences&datasources=Viva Corporation&datasources=PhyStandard&datasources=King Scientific&datasources=eNovation Chemicals&datasources=Thoreauchem&datasources=MolMall&datasources=ACINTS&datasources=Chemodex&datasources=Labseeker&datasources=Axon Medchem&datasources=BroadPharm&datasources=Rosewachem&datasources=Renaissance Chemicals&datasources=CEG Chemical&datasources=GFS Chemicals&datasources=OXchem&datasources=ACT Chemical&datasources=Bide Pharmatech&datasources=Arromax&datasources=Sinova&datasources=Atomax&datasources=TOKU-E&datasources=Mcule&datasources=Active Biopharma&datasources=Finornic Chemicals&datasources=Apollo Scientific Adopted&datasources=LKT Labs&datasources=Carbosynth&datasources=ChemStep&datasources=Wecoochem&datasources=Aromalake&datasources=W%26J PharmaChem, Inc.&datasources=Leverton-Clarke&datasources=Airedale Chemical&datasources=Corvinus Chemicals&datasources=Akerr Pharma&datasources=Debyesci&datasources=Xinyanhe Pharmatech&datasources=Megazyme International&datasources=Arkema&datasources=Advanced Technology %26 Industrial&datasources=Shenzhen Nexconn Pharmatechs Ltd.&datasources=Aspira Scientific&datasources=Shanghai Pengteng Fine Chemical Co., Ltd. &datasources=Wylton Jinglin&datasources=AZEPINE&datasources=Attomarker&datasources=OlainFarm&datasources=TripleBond&datasources=Exim&datasources=Helix Molecules&datasources=Santiago Laboratory Equipment&datasources=ChiralStar&datasources=Wolves Chemical&datasources=Hello Bio&datasources=SLI Technologies&datasources=A1 BioChem Labs&datasources=Tubepharm&datasources=A%26J Pharmtech&datasources=Aoyi International&datasources=4C Pharma Scientific&datasources=ACO Pharm&datasources=Chemcia Scientific&datasources=Natural Products Discovery Institute&datasources=A2Z Chemical&datasources=GuiChem&datasources=Acemol&datasources=Boerchem"
curl --data "CSID=$csid&token=$token&$datasrcs" www.chemspider.com/Search.asmx/CSID2ExtRefs
