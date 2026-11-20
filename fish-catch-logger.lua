-- fish-catch-logger.lua
-- Experimental chat listener and catch parser. No webhook delivery.
local FISH_RARITY = {
    ["1x1x1x1 comet shark"] = "Secret", -- single_source
    ["abyshorn fish"] = "Uncommon", -- matched_two_sources
    ["abyss seahorse"] = "Mythic", -- matched_two_sources
    ["ancient arapaima"] = "Uncommon", -- matched_two_sources
    ["ancient lochness monster"] = "Secret", -- matched_two_sources
    ["ancient pufferfish"] = "Legendary", -- matched_two_sources
    ["ancient squid"] = "Mythic", -- matched_two_sources
    ["ancient whale"] = "Secret", -- single_source
    ["angler fish"] = "Epic", -- single_source
    ["angrylion fish"] = "Epic", -- matched_two_sources
    ["antique watch"] = "Epic", -- single_source
    ["armored shark"] = "Secret", -- matched_two_sources
    ["arowana"] = "Uncommon", -- matched_two_sources
    ["ash basslet"] = "Common", -- matched_two_sources
    ["ashen kingfish"] = "Secret", -- single_source
    ["astra damsel"] = "Epic", -- matched_two_sources
    ["axolotl"] = "Legendary", -- matched_two_sources
    ["azure damsel"] = "Common", -- matched_two_sources
    ["baby shrimp"] = "Uncommon", -- matched_two_sources
    ["ballina angelfish"] = "Rare", -- matched_two_sources
    ["banded butterfly"] = "Uncommon", -- matched_two_sources
    ["bandit angelfish"] = "Uncommon", -- matched_two_sources
    ["barracuda fish"] = "Rare", -- matched_two_sources
    ["beanie leedsicheye"] = "Common", -- matched_two_sources
    ["big crystal goliath"] = "Secret", -- single_source
    ["big king jelly"] = "Secret", -- matched_two_sources
    ["blackcap basslet"] = "Uncommon", -- matched_two_sources
    ["blob fish"] = "Mythic", -- matched_two_sources
    ["blob shark"] = "Secret", -- single_source
    ["blobby shieldfish"] = "Epic", -- matched_two_sources
    ["blocky lochness monster"] = "Secret", -- single_source
    ["bloodmoon whale"] = "Secret", -- single_source
    ["blue lobster"] = "Legendary", -- matched_two_sources
    ["blue-banded goby"] = "Uncommon", -- matched_two_sources
    ["blueflame ray"] = "Mythic", -- matched_two_sources
    ["bluemato clownfish"] = "Uncommon", -- matched_two_sources
    ["blumato clownfish"] = "Uncommon", -- single_source
    ["boa angelfish"] = "Common", -- matched_two_sources
    ["boar fish"] = "Common", -- matched_two_sources
    ["bone whale"] = "Secret", -- matched_two_sources
    ["boney eel"] = "Rare", -- matched_two_sources
    ["bowtie blobby"] = "Uncommon", -- single_source
    ["bumblebee grouper"] = "Legendary", -- matched_two_sources
    ["candy butterfly"] = "Rare", -- matched_two_sources
    ["catfish"] = "Rare", -- matched_two_sources
    ["cavern dweller"] = "Mythic", -- matched_two_sources
    ["charmed tang"] = "Rare", -- matched_two_sources
    ["chill santa fish"] = "Uncommon", -- single_source
    ["christmas light carp"] = "Rare", -- single_source
    ["christmas penguin"] = "Legendary", -- single_source
    ["chrome tuna"] = "Legendary", -- matched_two_sources
    ["classy snowfish"] = "Epic", -- single_source
    ["clownfish"] = "Common", -- matched_two_sources
    ["coal tang"] = "Uncommon", -- matched_two_sources
    ["common present"] = "Common", -- single_source
    ["conch shell"] = "Uncommon", -- matched_two_sources
    ["coney fish"] = "Rare", -- matched_two_sources
    ["conspi angelfish"] = "Common", -- matched_two_sources
    ["copperband butterfly"] = "Common", -- matched_two_sources
    ["coral reaper"] = "Secret", -- single_source
    ["corazon damsel"] = "Common", -- matched_two_sources
    ["cosmic hammerhead shark"] = "Mythic", -- single_source
    ["cow clownfish"] = "Epic", -- matched_two_sources
    ["cozy carp"] = "Common", -- single_source
    ["cozy narwhal plushie"] = "Epic", -- single_source
    ["crocodile"] = "Mythic", -- matched_two_sources
    ["cryoshade glider"] = "Secret", -- single_source
    ["crystal crab"] = "Secret", -- matched_two_sources
    ["cypress rauta"] = "Uncommon", -- matched_two_sources
    ["dark eel"] = "Uncommon", -- matched_two_sources
    ["dark megalodon"] = "Secret", -- single_source
    ["dark tentacle"] = "Rare", -- matched_two_sources
    ["darwin clownfish"] = "Rare", -- matched_two_sources
    ["dead fish"] = "Common", -- matched_two_sources
    ["dead zombie shark"] = "Secret", -- single_source
    ["deep sea crab"] = "Legendary", -- matched_two_sources
    ["depthseeker ray"] = "Secret", -- single_source
    ["diamond ring"] = "Legendary", -- single_source
    ["domino damsel"] = "Epic", -- matched_two_sources
    ["doober fish"] = "Uncommon", -- matched_two_sources
    ["dorhey tang"] = "Epic", -- matched_two_sources
    ["dotted stingray"] = "Mythic", -- matched_two_sources
    ["drippy tucanare"] = "Uncommon", -- matched_two_sources
    ["eerie shark"] = "Secret", -- matched_two_sources
    ["electric eel"] = "Common", -- matched_two_sources
    ["elemental hydra"] = "Forgotten", -- single_source
    ["elemental tempest ray"] = "Secret", -- single_source
    ["elf guppy"] = "Common", -- single_source
    ["elretro gran maja"] = "Secret", -- single_source
    ["elshark gran maja"] = "Secret", -- single_source
    ["emerald winter whale"] = "Secret", -- single_source
    ["enchanted angelfish"] = "Legendary", -- matched_two_sources
    ["epic present"] = "Epic", -- single_source
    ["evolved enchant stone"] = "Legendary", -- single_source
    ["expensive chain"] = "Epic", -- single_source
    ["fade tang"] = "Common", -- matched_two_sources
    ["festive dolphin"] = "Mythic", -- single_source
    ["festive salmon"] = "Uncommon", -- single_source
    ["finny present"] = "Rare", -- single_source
    ["fire goby"] = "Rare", -- matched_two_sources
    ["firecoal damsel"] = "Epic", -- matched_two_sources
    ["flame angelfish"] = "Uncommon", -- matched_two_sources
    ["flame tyrant"] = "Secret", -- single_source
    ["flat fish"] = "Uncommon", -- matched_two_sources
    ["flatheaded whale shark"] = "Mythic", -- matched_two_sources
    ["flying fish"] = "Uncommon", -- matched_two_sources
    ["flying manta"] = "Legendary", -- matched_two_sources
    ["foxtrot koanfish"] = "Uncommon", -- matched_two_sources
    ["freshwater piranha"] = "Rare", -- matched_two_sources
    ["frog"] = "Rare", -- matched_two_sources
    ["frost moon whale"] = "Secret", -- single_source
    ["frostbite bluefinn"] = "Legendary", -- single_source
    ["frostbite leviathan"] = "Forgotten", -- single_source
    ["frostborn shark"] = "Secret", -- single_source
    ["frostfin"] = "Uncommon", -- single_source
    ["frostglow globe jelly"] = "Mythic", -- single_source
    ["frostwhisker"] = "Rare", -- single_source
    ["frozen tang"] = "Uncommon", -- single_source
    ["frozen tundra"] = "Legendary", -- single_source
    ["gar"] = "Uncommon", -- single_source
    ["gar fish"] = "Uncommon", -- single_source
    ["ghost shark"] = "Secret", -- matched_two_sources
    ["ghost worm fish"] = "Secret", -- single_source
    ["giant squid"] = "Secret", -- single_source
    ["gigabyte"] = "Secret", -- single_source
    ["gingerbread crab"] = "Epic", -- single_source
    ["gingerbread fish"] = "Uncommon", -- single_source
    ["gingerbread fish plushie"] = "Rare", -- single_source
    ["gingerbread ray"] = "Epic", -- single_source
    ["gingerbread starfish"] = "Uncommon", -- single_source
    ["glacerfin snapper"] = "Uncommon", -- single_source
    ["glacial serpent"] = "Secret", -- single_source
    ["glacier bass"] = "Epic", -- single_source
    ["gladiator shark"] = "Secret", -- matched_two_sources
    ["goliath tiger"] = "Epic", -- matched_two_sources
    ["goofy santa fish"] = "Common", -- single_source
    ["grand maja"] = "Secret", -- matched_two_sources
    ["great whale"] = "Secret", -- matched_two_sources
    ["greenbee grouper"] = "Legendary", -- matched_two_sources
    ["hacker shark"] = "Secret", -- matched_two_sources
    ["hammerhead shark"] = "Mythic", -- matched_two_sources
    ["hawks turtle"] = "Mythic", -- matched_two_sources
    ["heartbreak nessie"] = "Secret", -- single_source
    ["herring fish"] = "Common", -- matched_two_sources
    ["holiday angler plushie"] = "Epic", -- single_source
    ["holiday guppy plushie"] = "Uncommon", -- single_source
    ["holiday turtle plushie"] = "Rare", -- single_source
    ["icebreaker whale"] = "Secret", -- single_source
    ["icecap runner"] = "Common", -- single_source
    ["icefang angler"] = "Rare", -- single_source
    ["icey pufferfish"] = "Rare", -- single_source
    ["icy depths koi"] = "Rare", -- single_source
    ["icy fish"] = "Common", -- single_source
    ["iridesca"] = "Forgotten", -- single_source
    ["jellybeam"] = "Secret", -- single_source
    ["jellyfish"] = "Rare", -- matched_two_sources
    ["jennifer dottyback"] = "Common", -- matched_two_sources
    ["jewel tang"] = "Rare", -- matched_two_sources
    ["jingle bells fish"] = "Uncommon", -- single_source
    ["jinglefin"] = "Rare", -- single_source
    ["jolly crab"] = "Rare", -- single_source
    ["kau cardinal"] = "Rare", -- matched_two_sources
    ["king crab"] = "Secret", -- matched_two_sources
    ["king jelly"] = "Secret", -- single_source
    ["king mackerel"] = "Rare", -- single_source
    ["korean angelfish"] = "Rare", -- matched_two_sources
    ["kraken"] = "Secret", -- matched_two_sources
    ["krampus shark"] = "Secret", -- single_source
    ["lake sturgeon"] = "Legendary", -- matched_two_sources
    ["lava butterfly"] = "Uncommon", -- matched_two_sources
    ["lavafin tuna"] = "Legendary", -- matched_two_sources
    ["lined cardinal"] = "Legendary", -- single_source
    ["lined cardinal fish"] = "Epic", -- single_source
    ["lion fish"] = "Uncommon", -- matched_two_sources
    ["lobster"] = "Legendary", -- matched_two_sources
    ["lochness monster"] = "Secret", -- matched_two_sources
    ["loggerhead turtle"] = "Mythic", -- matched_two_sources
    ["longnose butterfly"] = "Epic", -- matched_two_sources
    ["magic tang"] = "Legendary", -- matched_two_sources
    ["magma goby"] = "Uncommon", -- matched_two_sources
    ["magma shark"] = "Mythic", -- matched_two_sources
    ["manoai statue"] = "Legendary", -- single_source
    ["manoai statue fish"] = "Legendary", -- single_source
    ["manta ray"] = "Mythic", -- matched_two_sources
    ["masked angelfish"] = "Common", -- matched_two_sources
    ["maze angelfish"] = "Uncommon", -- matched_two_sources
    ["megalodon"] = "Secret", -- matched_two_sources
    ["midnight blue wildes shark"] = "Secret", -- single_source
    ["mistle toe fish"] = "Uncommon", -- single_source
    ["mistle toe seahorse"] = "Rare", -- single_source
    ["monk fish"] = "Epic", -- matched_two_sources
    ["monster shark"] = "Secret", -- matched_two_sources
    ["moorish idol"] = "Epic", -- matched_two_sources
    ["mosasaur shark"] = "Secret", -- matched_two_sources
    ["mossy fishlet"] = "Rare", -- matched_two_sources
    ["narwhal"] = "Epic", -- matched_two_sources
    ["night glider fish"] = "Common", -- matched_two_sources
    ["northfin helper"] = "Uncommon", -- single_source
    ["nutcracker ray"] = "Mythic", -- single_source
    ["old boot"] = "Common", -- matched_two_sources
    ["orange basslet"] = "Uncommon", -- matched_two_sources
    ["orangy goby"] = "Common", -- matched_two_sources
    ["orca"] = "Secret", -- matched_two_sources
    ["ornament fish"] = "Uncommon", -- single_source
    ["panther eel"] = "Secret", -- matched_two_sources
    ["panther grouper"] = "Epic", -- matched_two_sources
    ["pearl"] = "Rare", -- single_source
    ["peppermint fish"] = "Rare", -- single_source
    ["peppermint spike"] = "Epic", -- single_source
    ["pilot fish"] = "Uncommon", -- matched_two_sources
    ["pink dolphin"] = "Legendary", -- single_source
    ["pirate blue lobster"] = "Rare", -- matched_two_sources
    ["primal axolotl"] = "Legendary", -- matched_two_sources
    ["primal lobster"] = "Legendary", -- matched_two_sources
    ["primordial octopus"] = "Mythic", -- matched_two_sources
    ["prismy seahorse"] = "Mythic", -- matched_two_sources
    ["pufferfish"] = "Epic", -- single_source
    ["purp blisfish"] = "Uncommon", -- matched_two_sources
    ["putterfish"] = "Epic", -- single_source
    ["pygmy goby"] = "Common", -- matched_two_sources
    ["queen crab"] = "Secret", -- matched_two_sources
    ["raccoon butterfly fish"] = "Uncommon", -- matched_two_sources
    ["rare present"] = "Rare", -- single_source
    ["red goatfish"] = "Uncommon", -- matched_two_sources
    ["red snapper"] = "Uncommon", -- matched_two_sources
    ["reef chromis"] = "Common", -- matched_two_sources
    ["reindeer fish"] = "Common", -- single_source
    ["reindeer guppy"] = "Common", -- single_source
    ["reindeer shark"] = "Legendary", -- single_source
    ["retro maja"] = "Secret", -- matched_two_sources
    ["robot kraken"] = "Secret", -- matched_two_sources
    ["rockfish"] = "Uncommon", -- matched_two_sources
    ["rockform cardinal"] = "Rare", -- matched_two_sources
    ["ruby"] = "Legendary", -- matched_two_sources
    ["runic axolotl"] = "Legendary", -- matched_two_sources
    ["runic lobster"] = "Legendary", -- matched_two_sources
    ["runic sea crustacean"] = "Mythic", -- matched_two_sources
    ["runic squid"] = "Mythic", -- matched_two_sources
    ["runic wispeye"] = "Common", -- matched_two_sources
    ["sail fish"] = "Uncommon", -- matched_two_sources
    ["sail tang"] = "Common", -- matched_two_sources
    ["salmon"] = "Uncommon", -- matched_two_sources
    ["santa guppy"] = "Common", -- single_source
    ["scare"] = "Secret", -- single_source
    ["scissortail dartfish"] = "Rare", -- matched_two_sources
    ["sea crustacean"] = "Mythic", -- matched_two_sources
    ["sea shell"] = "Uncommon", -- matched_two_sources
    ["sea shells"] = "Uncommon", -- single_source
    ["shark"] = "Mythic", -- matched_two_sources
    ["sheepshead"] = "Rare", -- single_source
    ["sheepshead fish"] = "Rare", -- single_source
    ["shrimp goby"] = "Uncommon", -- matched_two_sources
    ["silver tuna"] = "Uncommon", -- matched_two_sources
    ["skeleton angler fish"] = "Epic", -- matched_two_sources
    ["skeleton fish"] = "Common", -- matched_two_sources
    ["skeleton narwhal"] = "Secret", -- single_source
    ["skunk tilefish"] = "Common", -- matched_two_sources
    ["sky blue talon shark"] = "Secret", -- single_source
    ["slurpfish chromis"] = "Legendary", -- single_source
    ["snowflake puffer fish"] = "Uncommon", -- single_source
    ["sona fin fish"] = "Common", -- matched_two_sources
    ["soulveil koi"] = "Secret", -- single_source
    ["soulwake express"] = "Forgotten", -- single_source
    ["spear guardian"] = "Epic", -- matched_two_sources
    ["specked butterfly"] = "Common", -- single_source
    ["speckled butterfly"] = "Common", -- single_source
    ["spiritborn axolotl"] = "Secret", -- single_source
    ["spotted lantern fish"] = "Uncommon", -- matched_two_sources
    ["starfish"] = "Rare", -- matched_two_sources
    ["starjam tang"] = "Legendary", -- matched_two_sources
    ["strawberry choc megalodon"] = "Secret", -- single_source
    ["strawberry dotty"] = "Common", -- matched_two_sources
    ["sushi cardinal"] = "Epic", -- matched_two_sources
    ["swordfish"] = "Uncommon", -- matched_two_sources
    ["synodontis"] = "Legendary", -- matched_two_sources
    ["talon serpent"] = "Secret", -- matched_two_sources
    ["temple spokes tuna"] = "Legendary", -- matched_two_sources
    ["thinkler fish"] = "Uncommon", -- matched_two_sources
    ["thresher shark"] = "Mythic", -- matched_two_sources
    ["toothy fish"] = "Rare", -- matched_two_sources
    ["train wheel"] = "Rare", -- single_source
    ["tralalero tralala"] = "Mythic", -- single_source
    ["tree horse"] = "Legendary", -- single_source
    ["trench warden"] = "Forgotten", -- single_source
    ["tricolore butterfly"] = "Uncommon", -- matched_two_sources
    ["uncommon present"] = "Uncommon", -- single_source
    ["unicorn tang"] = "Epic", -- matched_two_sources
    ["vampire squid"] = "Epic", -- matched_two_sources
    ["vineyard kraken"] = "Secret", -- single_source
    ["vintage blue tang"] = "Common", -- matched_two_sources
    ["vintage damsel"] = "Uncommon", -- matched_two_sources
    ["viperangler fish"] = "Rare", -- matched_two_sources
    ["viperfish"] = "Uncommon", -- matched_two_sources
    ["volcanic basslet"] = "Common", -- matched_two_sources
    ["volsail tang"] = "Rare", -- matched_two_sources
    ["wahoo"] = "Uncommon", -- matched_two_sources
    ["watanabei angelfish"] = "Common", -- matched_two_sources
    ["water snake"] = "Uncommon", -- matched_two_sources
    ["waveback fish"] = "Common", -- matched_two_sources
    ["white clownfish"] = "Rare", -- matched_two_sources
    ["white tang"] = "Common", -- matched_two_sources
    ["wing parrotfish"] = "Uncommon", -- matched_two_sources
    ["winter frost shark"] = "Secret", -- single_source
    ["winter sweater redfin"] = "Uncommon", -- single_source
    ["worm fish"] = "Secret", -- matched_two_sources
    ["yellow damselfish"] = "Uncommon", -- matched_two_sources
    ["yellowfin tuna"] = "Legendary", -- matched_two_sources
    ["yellowstate angelfish"] = "Common", -- matched_two_sources
    ["zebra snakehead"] = "Uncommon", -- matched_two_sources
    ["zombie megalodon"] = "Secret", -- single_source
    ["zombie shark"] = "Secret", -- single_source
    ["zoster butterfly"] = "Common", -- matched_two_sources
}
-- Merchant supplied updated entries. Legend uses the existing Legendary filter.
FISH_RARITY["abyr squid"] = "Mythic"
FISH_RARITY["abyss seahorse"] = "Mythic"
FISH_RARITY["abyssal maw angler"] = "Legendary"
FISH_RARITY["aetherhorn charger"] = "Mythic"
FISH_RARITY["alligator snapper"] = "Legendary"
FISH_RARITY["ancient lochness monster"] = "Secret"
FISH_RARITY["ancient magma whale"] = "Secret"
FISH_RARITY["ancient pufferfish"] = "Legendary"
FISH_RARITY["ancient squid"] = "Mythic"
FISH_RARITY["aquaceratops"] = "Legendary"
FISH_RARITY["armor catfish"] = "Mythic"
FISH_RARITY["ashen kingfish"] = "Secret"
FISH_RARITY["aurora butterfly fish"] = "Legendary"
FISH_RARITY["aurora manatee"] = "Legendary"
FISH_RARITY["axolotl"] = "Legendary"
FISH_RARITY["azul crab"] = "Legendary"
FISH_RARITY["baby maya fish"] = "Mythic"
FISH_RARITY["bandit octopus"] = "Legendary"
FISH_RARITY["bioluminescent manta ray"] = "Mythic"
FISH_RARITY["biolumiscent"] = "Legendary"
FISH_RARITY["black tide shrimp"] = "Legendary"
FISH_RARITY["blackhole sea dragon"] = "Legendary"
FISH_RARITY["blob fish"] = "Mythic"
FISH_RARITY["blob shark"] = "Secret"
FISH_RARITY["bloodmoon whale"] = "Secret"
FISH_RARITY["blossom jelly"] = "Legendary"
FISH_RARITY["blue lobster"] = "Legendary"
FISH_RARITY["blue sea dragon"] = "Legendary"
FISH_RARITY["blueflame ray"] = "Mythic"
FISH_RARITY["bone whale"] = "Secret"
FISH_RARITY["brimstone catfish"] = "Legendary"
FISH_RARITY["bumblebee grouper"] = "Legendary"
FISH_RARITY["cactus spearfish"] = "Mythic"
FISH_RARITY["captain pufferfish"] = "Legendary"
FISH_RARITY["caustic maw"] = "Secret"
FISH_RARITY["cavern dweller"] = "Mythic"
FISH_RARITY["cerulean dragon"] = "Forgotten"
FISH_RARITY["cerulean luker"] = "Mythic"
FISH_RARITY["chrome tuna"] = "Legendary"
FISH_RARITY["cindering reefback"] = "Mythic"
FISH_RARITY["cloudy seal"] = "Legendary"
FISH_RARITY["compas carp"] = "Legendary"
FISH_RARITY["coral reaper"] = "Secret"
FISH_RARITY["coral whale"] = "Secret"
FISH_RARITY["cosmic blobfish"] = "Mythic"
FISH_RARITY["cosmic hammerhead shark"] = "Mythic"
FISH_RARITY["cosmic mutant shark"] = "Secret"
FISH_RARITY["cosmic seahorse"] = "Legendary"
FISH_RARITY["cow narwhale"] = "Mythic"
FISH_RARITY["cowboy octopus"] = "Legendary"
FISH_RARITY["crimson dreadtusk"] = "Forgotten"
FISH_RARITY["crocodile"] = "Mythic"
FISH_RARITY["cryoclaw lobster"] = "Legendary"
FISH_RARITY["cryoshade gilder"] = "Secret"
FISH_RARITY["crystal crab"] = "Secret"
FISH_RARITY["crystal goliath"] = "Secret"
FISH_RARITY["crystal lancer"] = "Legendary"
FISH_RARITY["crystal octopus"] = "Legendary"
FISH_RARITY["crystal salamander"] = "Legendary"
FISH_RARITY["cursed kraken"] = "Secret"
FISH_RARITY["cute dumbo"] = "Legendary"
FISH_RARITY["dark megalodon"] = "Secret"
FISH_RARITY["dawnbringer betta"] = "Secret"
FISH_RARITY["dawnflare crab"] = "Mythic"
FISH_RARITY["deep sea crab"] = "Legendary"
FISH_RARITY["deepsea monster axolotl"] = "Secret"
FISH_RARITY["dephseeker ray"] = "Secret"
FISH_RARITY["diamond ring"] = "Legendary"
FISH_RARITY["dotted stingray"] = "Mythic"
FISH_RARITY["eerie shark"] = "Secret"
FISH_RARITY["elemental hydra"] = "Forgotten"
FISH_RARITY["elemental tempestray"] = "Secret"
FISH_RARITY["elpirate gran maja"] = "Secret"
FISH_RARITY["elshark gran maja"] = "Secret"
FISH_RARITY["embercrux"] = "Legendary"
FISH_RARITY["enchanted angelfish"] = "Legendary"
FISH_RARITY["esoteric"] = "Legendary"
FISH_RARITY["everbloom"] = "Forgotten"
FISH_RARITY["evolved enchant stone"] = "Legendary"
FISH_RARITY["fish fossil"] = "Legendary"
FISH_RARITY["flame tyrant"] = "Forgotten"
FISH_RARITY["flarebait angler"] = "Legendary"
FISH_RARITY["flatheaded whale shark"] = "Mythic"
FISH_RARITY["fluorivane"] = "Forgotten"
FISH_RARITY["flying manta"] = "Legendary"
FISH_RARITY["fossilized shark"] = "Mythic"
FISH_RARITY["frostborn shark"] = "Secret"
FISH_RARITY["frostbound oracle"] = "Mythic"
FISH_RARITY["frostglass mako shark"] = "Mythic"
FISH_RARITY["frostmoon whale"] = "Secret"
FISH_RARITY["geode drifter"] = "Legendary"
FISH_RARITY["ghost shark"] = "Secret"
FISH_RARITY["giant squid"] = "Secret"
FISH_RARITY["glacial serpent"] = "Secret"
FISH_RARITY["glacierback sea turtle"] = "Legendary"
FISH_RARITY["gladiator shark"] = "Secret"
FISH_RARITY["goblin shark"] = "Mythic"
FISH_RARITY["great whale"] = "Secret"
FISH_RARITY["greenbee grouper"] = "Legendary"
FISH_RARITY["groveback hermit"] = "Mythic"
FISH_RARITY["guttenfang"] = "Legendary"
FISH_RARITY["hammerhead shark"] = "Mythic"
FISH_RARITY["hank's diary"] = "Mythic"
FISH_RARITY["hawks turtle"] = "Mythic"
FISH_RARITY["hermit crab"] = "Mythic"
FISH_RARITY["hybodus shark"] = "Mythic"
FISH_RARITY["hyperjelly"] = "Legendary"
FISH_RARITY["jelly beam"] = "Secret"
FISH_RARITY["jellypad"] = "Legendary"
FISH_RARITY["king crab"] = "Secret"
FISH_RARITY["king jelly"] = "Secret"
FISH_RARITY["kitefin fish"] = "Legendary"
FISH_RARITY["kohana volcano"] = "Legendary"
FISH_RARITY["komodo dragon"] = "Mythic"
FISH_RARITY["lake strurqeon"] = "Legendary"
FISH_RARITY["lavafin tuna"] = "Legendary"
FISH_RARITY["lined cardinal fish"] = "Legendary"
FISH_RARITY["lobster"] = "Legendary"
FISH_RARITY["lochness monster"] = "Secret"
FISH_RARITY["loggerhead turtle"] = "Mythic"
FISH_RARITY["lumenray"] = "Legendary"
FISH_RARITY["lumilotl"] = "Legendary"
FISH_RARITY["luminos fish"] = "Mythic"
FISH_RARITY["magic tang"] = "Legendary"
FISH_RARITY["magma crab"] = "Legendary"
FISH_RARITY["magma piranha"] = "Legendary"
FISH_RARITY["magma ptychodus"] = "Mythic"
FISH_RARITY["magma shark"] = "Mythic"
FISH_RARITY["magma swordfish"] = "Mythic"
FISH_RARITY["magmaquill pufferfish"] = "Legendary"
FISH_RARITY["manoai statue fish"] = "Legendary"
FISH_RARITY["manta ray"] = "Mythic"
FISH_RARITY["megalodon"] = "Secret"
FISH_RARITY["midnight star squid"] = "Legendary"
FISH_RARITY["monster shark"] = "Secret"
FISH_RARITY["moonstrider turtle"] = "Mythic"
FISH_RARITY["mossaurus shark"] = "Secret"
FISH_RARITY["neonite fish"] = "Legendary"
FISH_RARITY["nine tailedfish"] = "Legendary"
FISH_RARITY["opalshell nail"] = "Mythic"
FISH_RARITY["orca"] = "Secret"
FISH_RARITY["outlaw seahorse"] = "Legendary"
FISH_RARITY["overlord hydra"] = "Forgotten"
FISH_RARITY["pailatee"] = "Mythic"
FISH_RARITY["panther eel"] = "Secret"
FISH_RARITY["pelagon"] = "Secret"
FISH_RARITY["phanton goblin shark"] = "Mythic"
FISH_RARITY["pink dolphin"] = "Legendary"
FISH_RARITY["pirate megalodon"] = "Secret"
FISH_RARITY["pirate sailfish"] = "Mythic"
FISH_RARITY["plasma serpent"] = "Mythic"
FISH_RARITY["plasma shark"] = "Mythic"
FISH_RARITY["postmaster koi"] = "Mythic"
FISH_RARITY["primal axolotl"] = "Legendary"
FISH_RARITY["primal lobster"] = "Legendary"
FISH_RARITY["primordial octopus"] = "Mythic"
FISH_RARITY["prismy seahorse"] = "Mythic"
FISH_RARITY["pyroclast stonefish"] = "Mythic"
FISH_RARITY["queen crab"] = "Secret"
FISH_RARITY["radiant dolphin"] = "Legendary"
FISH_RARITY["ragnarex"] = "Forgotten"
FISH_RARITY["rainy dumbo"] = "Legendary"
FISH_RARITY["riftborn arowana"] = "Secret"
FISH_RARITY["rocky scorpion"] = "Legendary"
FISH_RARITY["ruby"] = "Legendary"
FISH_RARITY["runebound crocodile"] = "Mythic"
FISH_RARITY["runic abyssal shark"] = "Mythic"
FISH_RARITY["runic axolotl"] = "Legendary"
FISH_RARITY["runic crustacean"] = "Mythic"
FISH_RARITY["runic enchant stone"] = "Secret"
FISH_RARITY["runic lobster"] = "Legendary"
FISH_RARITY["runic squid"] = "Mythic"
FISH_RARITY["rustborne shark"] = "Mythic"
FISH_RARITY["sacret guardian squid"] = "Legendary"
FISH_RARITY["sailor crab"] = "Legendary"
FISH_RARITY["satrry nights sawfish"] = "Mythic"
FISH_RARITY["saw fish"] = "Legendary"
FISH_RARITY["scare"] = "Secret"
FISH_RARITY["scorching veinmaw"] = "Forgotten"
FISH_RARITY["sea crustacean"] = "Mythic"
FISH_RARITY["sea eater"] = "Forgotten"
FISH_RARITY["seraphyrion"] = "Forgotten"
FISH_RARITY["sharp one"] = "Mythic"
FISH_RARITY["sheriff lobster"] = "Legendary"
FISH_RARITY["sheriff sawfish"] = "Mythic"
FISH_RARITY["skeleton narwhal"] = "Secret"
FISH_RARITY["slurpfish chromuis"] = "Legendary"
FISH_RARITY["snorkel sturgeon"] = "Legendary"
FISH_RARITY["solarflare koi"] = "Mythic"
FISH_RARITY["spectral seamoth"] = "Mythic"
FISH_RARITY["spfin shark"] = "Mythic"
FISH_RARITY["spiritborn axolotl"] = "Secret"
FISH_RARITY["sporeback sturgeon"] = "Mythic"
FISH_RARITY["star snail"] = "Legendary"
FISH_RARITY["starjam tang"] = "Legendary"
FISH_RARITY["starlight manta ray"] = "Mythic"
FISH_RARITY["steamforged whale"] = "Mythic"
FISH_RARITY["steamwork sawfish"] = "Mythic"
FISH_RARITY["stormcaller hammerhead"] = "Mythic"
FISH_RARITY["stormfrill axolotl"] = "Mythic"
FISH_RARITY["stormy dumbo"] = "Legendary"
FISH_RARITY["strippled seahorse"] = "Mythic"
FISH_RARITY["sunbather mantra ray"] = "Legendary"
FISH_RARITY["sunfang nautilus"] = "Legendary"
FISH_RARITY["sunfire carp"] = "Legendary"
FISH_RARITY["sunpiercer swordfish"] = "Mythic"
FISH_RARITY["synodontis"] = "Legendary"
FISH_RARITY["teacup puffer"] = "Legendary"
FISH_RARITY["temple spokes tuna"] = "Legendary"
FISH_RARITY["teslacoil octopus"] = "Legendary"
FISH_RARITY["thin armor shark"] = "Secret"
FISH_RARITY["thresher shark"] = "Mythic"
FISH_RARITY["thunder manta ray"] = "Mythic"
FISH_RARITY["thunder squid"] = "Mythic"
FISH_RARITY["thundercrest ray"] = "Legendary"
FISH_RARITY["thunderhead cuttlefish"] = "Legendary"
FISH_RARITY["thunderstorm jelly"] = "Legendary"
FISH_RARITY["thunderzilla"] = "Forgotten"
FISH_RARITY["tidecrest dolphin"] = "Legendary"
FISH_RARITY["treasure crab"] = "Legendary"
FISH_RARITY["tribunal withering core"] = "Secret"
FISH_RARITY["viridis luker"] = "Secret"
FISH_RARITY["withering core"] = "Secret"
FISH_RARITY["worm fish"] = "Secret"
FISH_RARITY["yellowfin tuna"] = "Legendary"

local RARITY_ORDER = { "Legendary", "Mythic", "Secret", "Forgotten" }
local selectedRarities = {}
for _, rarity in ipairs(RARITY_ORDER) do selectedRarities[rarity] = true end
local function classifyFish(name)
    local normalized = name:lower():gsub("%s+", " "):match("^%s*(.-)%s*$")
    return FISH_RARITY[normalized] or "Unknown"
end
local TextChatService = game:GetService("TextChatService")
local MUTATIONS = { "Haunted", "Golden" }

local function trim(text)
    return text:match("^%s*(.-)%s*$")
end

local function expandNumber(text)
    local number, suffix = text:match("^([%d%.]+)([KkMmBb]?)$")
    number = tonumber(number)
    if not number then return nil end
    local multipliers = { K = 1000, M = 1000000, B = 1000000000 }
    return number * (multipliers[suffix:upper()] or 1)
end

table.sort(MUTATIONS, function(a, b) return #a > #b end)

local function parseCatch(message)
    local plain = message:gsub("<[^>]+>", "")
    local player, details, weight, rarity = plain:match(
        "(%S+)%s+obtained%s+(.+)%s+%(([^()]+)%)"
        .. "%s+with%s+a%s+1%s+in%s+([%d%.]+[KkMmBb]?)"
    )
    if not player then return nil end
    details = trim(details)
    if details:sub(1, 3) == "an " then
        details = trim(details:sub(4))
    elseif details:sub(1, 2) == "a " then
        details = trim(details:sub(3))
    end
    local mutation
    local big, shiny = false, false
    while details ~= "" do
        local matched = false
        if details:sub(1, 4) == "Big " then
            big = true
            details = trim(details:sub(5))
            matched = true
        elseif details:sub(1, 6) == "Shiny " then
            shiny = true
            details = trim(details:sub(7))
            matched = true
        else
            for _, name in ipairs(MUTATIONS) do
                if details:sub(1, #name + 1) == name .. " " then
                    mutation = name
                    details = trim(details:sub(#name + 2))
                    matched = true
                    break
                end
            end
        end
        if not matched then break end
    end
    if details == "" then return nil end
    local weightNumber = trim(weight):match("^([%d%.]+[KkMmBb]?)%s*[Kk][Gg]$")
    return {
        player_name = player,
        fish_name = details,
        mutation = mutation,
        big = big,
        shiny = shiny,
        weight_raw = weight,
        weight_kg = weightNumber and expandNumber(weightNumber),
        rarity_raw = "1 in " .. rarity,
        rarity_denominator = expandNumber(rarity),
        raw_message = plain,
    }
end

-- Local webhook panel. URL is kept in memory, not saved to GitHub.
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
if not player then
    error("[Fish Logger] Jalankan dari sisi pemain/client.")
end
local playerGui = player:WaitForChild("PlayerGui", 15)
if not playerGui then error("PlayerGui tidak tersedia") end
local oldGui = playerGui:FindFirstChild("FishCatchLoggerPanel")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "FishCatchLoggerPanel"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(340, 300)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(27, 30, 39)
frame.Parent = gui
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -56, 0, 36)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "fish logger | 4 rarity"
title.Parent = frame
local body = Instance.new("ScrollingFrame")
body.Position = UDim2.fromOffset(8, 38)
body.Size = UDim2.new(1, -16, 1, -46)
body.BackgroundTransparency = 1
body.BorderSizePixel = 0
body.ScrollBarThickness = 5
body.ScrollingDirection = Enum.ScrollingDirection.Y
body.AutomaticCanvasSize = Enum.AutomaticSize.Y
body.CanvasSize = UDim2.new()
body.Parent = frame
local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)
layout.Parent = body
local order = 0
local function ordered(item)
    order = order + 1
    item.LayoutOrder = order
    item.Parent = body
    return item
end
local function label(text)
    local item = Instance.new("TextLabel")
    item.Size = UDim2.new(1, -12, 0, 22)
    item.AutomaticSize = Enum.AutomaticSize.Y
    item.BackgroundTransparency = 1
    item.TextColor3 = Color3.fromRGB(235, 235, 240)
    item.Font = Enum.Font.SourceSans
    item.TextSize = 14
    item.TextWrapped = true
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.TextYAlignment = Enum.TextYAlignment.Top
    item.Text = text
    return ordered(item)
end
label("webhook JSON: nama_pemain, nama_ikan, kelangkaan, mutasi, shiny, big")
local urlBox = Instance.new("TextBox")
urlBox.Size = UDim2.new(1, -12, 0, 36)
urlBox.BackgroundColor3 = Color3.fromRGB(45, 49, 61)
urlBox.TextColor3 = Color3.new(1, 1, 1)
urlBox.TextSize = 14
urlBox.ClearTextOnFocus = false
urlBox.PlaceholderText = "URL webhook HTTPS"
urlBox.Text = ""
urlBox.TextTruncate = Enum.TextTruncate.AtEnd
ordered(urlBox)
local masterButton = Instance.new("TextButton")
masterButton.Size = UDim2.new(1, -12, 0, 36)
masterButton.BackgroundColor3 = Color3.fromRGB(130, 52, 52)
masterButton.TextColor3 = Color3.new(1, 1, 1)
masterButton.TextSize = 15
masterButton.Text = "Koneksi utama: OFF"
ordered(masterButton)
local actionRow = Instance.new("Frame")
actionRow.Size = UDim2.new(1, -12, 0, 34)
actionRow.BackgroundTransparency = 1
ordered(actionRow)
local function button(text, x, width)
    local item = Instance.new("TextButton")
    item.Position = UDim2.new(x, 0, 0, 0)
    item.Size = UDim2.new(width, -4, 1, 0)
    item.BackgroundColor3 = Color3.fromRGB(55, 92, 150)
    item.TextColor3 = Color3.new(1, 1, 1)
    item.TextSize = 14
    item.TextWrapped = true
    item.Text = text
    item.Parent = actionRow
    return item
end
local testButton = button("Tes webhook", 0, 0.5)
local toggleButton = button("kirim: off", 0.5, 0.5)
toggleButton.BackgroundColor3 = Color3.fromRGB(130, 52, 52)
local function updateSendButton(isOn)
    toggleButton.Text = isOn and "kirim: on" or "kirim: off"
    toggleButton.BackgroundColor3 = isOn
        and Color3.fromRGB(35, 112, 78)
        or Color3.fromRGB(130, 52, 52)
end
label("filter tangkapan dan webhook")
local filters = Instance.new("Frame")
filters.Size = UDim2.new(1, -12, 0, 70)
filters.BackgroundTransparency = 1
ordered(filters)
local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.new(0.5, -4, 0, 32)
grid.CellPadding = UDim2.fromOffset(6, 6)
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.Parent = filters
for index, rarity in ipairs(RARITY_ORDER) do
    local key = rarity
    local name = key == "Legendary" and "legend" or key:lower()
    local filter = Instance.new("TextButton")
    filter.LayoutOrder = index
    filter.TextColor3 = Color3.new(1, 1, 1)
    filter.TextSize = 14
    filter.TextWrapped = true
    filter.Parent = filters
    local function refresh()
        filter.Text = name .. (selectedRarities[key] and " : on" or " : off")
        filter.BackgroundColor3 = selectedRarities[key]
            and Color3.fromRGB(35, 112, 78) or Color3.fromRGB(66, 66, 73)
    end
    filter.Activated:Connect(function()
        selectedRarities[key] = not selectedRarities[key]
        refresh()
    end)
    refresh()
end
label("Status dan tangkapan terakhir:")
local statusLabel = label("Panel siap; menunggu listener.")
local deliveryLabel = label("Webhook: belum ada pengiriman di sesi ini.")
local function setDeliveryStatus(text)
    if deliveryLabel.Parent then deliveryLabel.Text = "Webhook: " .. text end
end
local lastLabel = label("Belum ada tangkapan yang terbaca.")
label("filter hanya untuk rarity dikenal; tangkapan belum dikenali tetap diteruskan.")
local function setStatus(text)
    if statusLabel.Parent then statusLabel.Text = text end
end
local function resizePanel()
    local camera = workspace.CurrentCamera
    if camera then
        local size = camera.ViewportSize
        frame.Size = UDim2.fromOffset(math.min(340, math.max(180, size.X - 24)),
            math.min(300, math.max(130, size.Y - 48)))
    end
end
resizePanel()
gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizePanel)
local enabled = false
local activeUrl = nil
local sending = false
local masterEnabled = false
local stoppedGeneration = 0
local disposed = false
local connection = nil
local connectionKey = "__FishCatchLoggerConnection"
local function readUrl()
    local url = trim(urlBox.Text)
    if not url:match("^https://[^%s]+$") then
        return nil, "Masukkan URL HTTPS tanpa spasi."
    end
    return url
end
local function transport()
    if type(request) == "function" then return request end
    if type(http_request) == "function" then return http_request end
    if type(syn) == "table" and type(syn.request) == "function" then
        return syn.request
    end
    return nil
end
-- Direct JSON catch payload using the receiving application field names.
local function makeCatchPayload(catch, tier)
    return {
        nama_pemain = catch.player_name,
        nama_ikan = catch.fish_name,
        kelangkaan = tier,
        mutasi = catch.mutation or "",
        shiny = catch.shiny,
        big = catch.big,
    }
end
local function postContent(url, content, isTest, catchPayload)
    if disposed or not masterEnabled then
        setDeliveryStatus("Koneksi utama OFF.")
        return
    end
    local generation = stoppedGeneration
    if sending then
        setDeliveryStatus("Sedang mengirim. Pesan ini tidak dikirim; tidak ada antrean.")
        return
    end
    local sendRequest = transport()
    if not sendRequest then
        setDeliveryStatus("Fungsi HTTP request tidak tersedia di lingkungan ini.")
        return
    end
    sending = true
    setDeliveryStatus("Mengirim...")
    task.spawn(function()
        if disposed or not masterEnabled or generation ~= stoppedGeneration then
            sending = false
            return
        end
        local ok, response = pcall(function()
            return sendRequest({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(catchPayload or { content = content }),
            })
        end)
        sending = false
        if disposed or not masterEnabled or generation ~= stoppedGeneration then return end
        if not ok then
            setDeliveryStatus("Request gagal. URL disembunyikan; periksa koneksi/endpoint.")
            return
        end
        local code = type(response) == "table"
            and tonumber(response.StatusCode or response.Status) or nil
        if code and code >= 200 and code < 300 then
            if isTest then
                setDeliveryStatus("Tes diterima HTTP " .. code .. ". Cek rekap web sebelum mengaktifkan otomatis.")
            else
                setDeliveryStatus("Diterima HTTP " .. code .. ".")
            end
        else
            setDeliveryStatus("Belum berhasil. HTTP: " .. tostring(code or "tidak diketahui") .. ". Cek format API.")
        end
    end)
end

testButton.Activated:Connect(function()
    local url, err = readUrl()
    if not url then setStatus(err) return end
    -- Test is sent only after the user presses this button.
    postContent(url, "[TEST] Fish Catch Logger: tes koneksi, bukan tangkapan ikan.", true)
end)
toggleButton.Activated:Connect(function()
    if not masterEnabled then setStatus("Aktifkan koneksi utama dulu.") return end
    if enabled then
        stoppedGeneration = stoppedGeneration + 1
        enabled = false
        activeUrl = nil
        updateSendButton(false)
        setStatus("Pengiriman berikutnya dinonaktifkan. Request yang berjalan tidak dibatalkan.")
        return
    end
    local url, err = readUrl()
    if not url then setStatus(err) return end
    if not transport() then setStatus("Fungsi HTTP request tidak tersedia.") return end
    activeUrl = url
    enabled = true
    updateSendButton(true)
    setStatus("Otomatis aktif untuk pesan baru yang berhasil dibaca.")
end)
urlBox:GetPropertyChangedSignal("Text"):Connect(function()
    stoppedGeneration = stoppedGeneration + 1
    enabled = false
    activeUrl = nil
    updateSendButton(false)
end)
local function sendCatch(catch)
    if disposed or not masterEnabled then return end
    local rarityCategory = classifyFish(catch.fish_name)
    if rarityCategory ~= "Unknown" and not selectedRarities[rarityCategory] then
        setStatus("Tangkapan dilewati oleh filter rarity: " .. rarityCategory)
        return
    end
    lastLabel.Text = catch.player_name .. " | " .. catch.fish_name
        .. " | " .. catch.weight_raw .. " | " .. catch.rarity_raw
    if enabled and activeUrl then
        -- Keep one JSON schema for all catches. Never fabricate an unknown rarity.
        local payload = makeCatchPayload(catch, rarityCategory)
        postContent(activeUrl, catch.raw_message, false, payload)
    else
        setStatus("Tangkapan terbaca. Pengiriman otomatis masih OFF.")
    end
end
-- Main switch manages this script's actual chat connection.
if _G[connectionKey] then
    pcall(function() _G[connectionKey]:Disconnect() end)
    _G[connectionKey] = nil
end
local function disconnectListener()
    if connection then
        local old = connection
        connection = nil
        old:Disconnect()
        if _G[connectionKey] == old then _G[connectionKey] = nil end
    end
end
local function stopMain()
    masterEnabled = false
    stoppedGeneration = stoppedGeneration + 1
    enabled = false
    activeUrl = nil
    disconnectListener()
    masterButton.Text = "Koneksi utama: OFF"
    masterButton.BackgroundColor3 = Color3.fromRGB(130, 52, 52)
    updateSendButton(false)
    setStatus("OFF: listener terputus. Request yang sudah terkirim tidak dapat ditarik.")
end
local function startMain()
    if disposed or masterEnabled then return end
    local ok, result = pcall(function()
        return TextChatService.MessageReceived:Connect(function(message)
            if disposed or not masterEnabled then return end
            local text = message.Text
            if type(text) ~= "string" then return end
            local catch = parseCatch(text)
            if catch then sendCatch(catch) end
        end)
    end)
    if not ok then
        setStatus("Gagal menghubungkan listener. Koneksi tetap OFF.")
        return
    end
    connection = result
    _G[connectionKey] = connection
    masterEnabled = true
    masterButton.Text = "Koneksi utama: ON"
    masterButton.BackgroundColor3 = Color3.fromRGB(35, 112, 78)
    setStatus("Listener ON. Kirim otomatis masih OFF; aktifkan terpisah.")
end
masterButton.Activated:Connect(function()
    if masterEnabled then stopMain() else startMain() end
end)
gui.Destroying:Connect(function()
    disposed = true
    stopMain()
end)
setStatus("Koneksi utama OFF. Aktifkan untuk membaca pesan baru.")

-- Minimize hides the full panel but leaves the listener running.
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = UDim2.new(0, 30, 0, 26)
minimizeButton.Position = UDim2.new(1, -36, 0, 6)
minimizeButton.BackgroundColor3 = Color3.fromRGB(55, 92, 150)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextSize = 20
minimizeButton.Text = "-"
minimizeButton.ZIndex = 5
minimizeButton.Parent = frame

local restoreButton = Instance.new("TextButton")
restoreButton.Name = "Restore"
restoreButton.Size = UDim2.new(0, 150, 0, 40)
restoreButton.Position = UDim2.new(0, 12, 0.5, -20)
restoreButton.BackgroundColor3 = Color3.fromRGB(55, 92, 150)
restoreButton.TextColor3 = Color3.new(1, 1, 1)
restoreButton.TextSize = 16
restoreButton.Text = "Fish Logger [+]"
restoreButton.Visible = false
restoreButton.Parent = gui

minimizeButton.Activated:Connect(function()
    frame.Visible = false
    restoreButton.Visible = true
    urlBox:ReleaseFocus()
end)
restoreButton.Activated:Connect(function()
    frame.Visible = true
    restoreButton.Visible = false
end)

gui.Parent = playerGui
