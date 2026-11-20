-- Fish Catch Logger
-- Auto-save URL ON/OFF dan minimize panda.
-- Mendukung tangkapan dengan maupun tanpa berat.
-- Koneksi dan pengiriman otomatis OFF saat mulai.

local FISH_RARITY = {}

local FISH_GROUPS = {
    Common = [[
ash basslet
azure damsel
beanie leedsicheye
boa angelfish
boar fish
clownfish
common present
conspi angelfish
copperband butterfly
corazon damsel
cozy carp
dead fish
electric eel
elf guppy
fade tang
goofy santa fish
herring fish
icecap runner
icy fish
jennifer dottyback
masked angelfish
night glider fish
old boot
orangy goby
pygmy goby
reef chromis
reindeer fish
reindeer guppy
runic wispeye
sail tang
santa guppy
skeleton fish
skunk tilefish
sona fin fish
specked butterfly
speckled butterfly
strawberry dotty
vintage blue tang
volcanic basslet
watanabei angelfish
waveback fish
white tang
yellowstate angelfish
zoster butterfly
]],

    Uncommon = [[
abyshorn fish
ancient arapaima
arowana
baby shrimp
banded butterfly
bandit angelfish
blackcap basslet
blue-banded goby
bluemato clownfish
blumato clownfish
bowtie blobby
chill santa fish
coal tang
conch shell
cypress rauta
dark eel
doober fish
drippy tucanare
festive salmon
flame angelfish
flat fish
flying fish
foxtrot koanfish
frostfin
frozen tang
gar
gar fish
gingerbread fish
gingerbread starfish
glacerfin snapper
holiday guppy plushie
jingle bells fish
lava butterfly
lion fish
magma goby
maze angelfish
mistle toe fish
northfin helper
orange basslet
ornament fish
pilot fish
purp blisfish
raccoon butterfly fish
red goatfish
red snapper
rockfish
sail fish
salmon
sea shell
sea shells
shrimp goby
silver tuna
snowflake puffer fish
spotted lantern fish
swordfish
thinkler fish
tricolore butterfly
uncommon present
vintage damsel
viperfish
wahoo
water snake
wing parrotfish
winter sweater redfin
yellow damselfish
zebra snakehead
]],

    Rare = [[
ballina angelfish
barracuda fish
boney eel
candy butterfly
catfish
charmed tang
christmas light carp
coney fish
dark tentacle
darwin clownfish
finny present
fire goby
freshwater piranha
frog
frostwhisker
gingerbread fish plushie
holiday turtle plushie
icefang angler
icey pufferfish
icy depths koi
jellyfish
jewel tang
jinglefin
jolly crab
kau cardinal
king mackerel
korean angelfish
mistle toe seahorse
mossy fishlet
pearl
peppermint fish
pirate blue lobster
rare present
rockform cardinal
scissortail dartfish
sheepshead
sheepshead fish
starfish
toothy fish
train wheel
viperangler fish
volsail tang
white clownfish
]],

    Epic = [[
angler fish
angrylion fish
antique watch
astra damsel
blobby shieldfish
classy snowfish
cow clownfish
cozy narwhal plushie
domino damsel
dorhey tang
epic present
expensive chain
firecoal damsel
gingerbread crab
gingerbread ray
glacier bass
goliath tiger
holiday angler plushie
longnose butterfly
monk fish
moorish idol
narwhal
panther grouper
peppermint spike
pufferfish
putterfish
skeleton angler fish
spear guardian
sushi cardinal
unicorn tang
vampire squid
]],

    Legendary = [[
ancient pufferfish
axolotl
blue lobster
bumblebee grouper
christmas penguin
chrome tuna
deep sea crab
diamond ring
enchanted angelfish
evolved enchant stone
flying manta
frostbite bluefinn
frozen tundra
greenbee grouper
lake sturgeon
lavafin tuna
lined cardinal
lined cardinal fish
lobster
magic tang
manoai statue
manoai statue fish
pink dolphin
primal axolotl
primal lobster
reindeer shark
ruby
runic axolotl
runic lobster
slurpfish chromis
starjam tang
synodontis
temple spokes tuna
tree horse
yellowfin tuna
abyssal maw angler
alligator snapper
aquaceratops
aurora butterfly fish
aurora manatee
azul crab
bandit octopus
biolumiscent
black tide shrimp
blackhole sea dragon
blossom jelly
blue sea dragon
brimstone catfish
captain pufferfish
cloudy seal
compas carp
cosmic seahorse
cowboy octopus
cryoclaw lobster
crystal lancer
crystal octopus
crystal salamander
cute dumbo
embercrux
esoteric
fish fossil
flarebait angler
geode drifter
glacierback sea turtle
guttenfang
hyperjelly
jellypad
kitefin fish
kohana volcano
lake strurqeon
lumenray
lumilotl
magma crab
magma piranha
magmaquill pufferfish
midnight star squid
neonite fish
nine tailedfish
outlaw seahorse
radiant dolphin
rainy dumbo
rocky scorpion
sacret guardian squid
sailor crab
saw fish
sheriff lobster
slurpfish chromuis
snorkel sturgeon
star snail
stormy dumbo
sunbather mantra ray
sunfang nautilus
sunfire carp
teacup puffer
teslacoil octopus
thundercrest ray
thunderhead cuttlefish
thunderstorm jelly
tidecrest dolphin
treasure crab
]],

    Mythic = [[
abyss seahorse
ancient squid
blob fish
blueflame ray
cavern dweller
cosmic hammerhead shark
crocodile
dotted stingray
festive dolphin
flatheaded whale shark
frostglow globe jelly
hammerhead shark
hawks turtle
loggerhead turtle
magma shark
manta ray
nutcracker ray
primordial octopus
prismy seahorse
runic sea crustacean
runic squid
sea crustacean
shark
thresher shark
tralalero tralala
abyr squid
aetherhorn charger
armor catfish
baby maya fish
bioluminescent manta ray
cactus spearfish
cerulean luker
cindering reefback
cosmic blobfish
cow narwhale
dawnflare crab
fossilized shark
frostbound oracle
frostglass mako shark
goblin shark
groveback hermit
hank's diary
hermit crab
hybodus shark
komodo dragon
luminos fish
magma ptychodus
magma swordfish
moonstrider turtle
opalshell nail
pailatee
phanton goblin shark
pirate sailfish
plasma serpent
plasma shark
postmaster koi
pyroclast stonefish
runebound crocodile
runic abyssal shark
runic crustacean
rustborne shark
satrry nights sawfish
sharp one
sheriff sawfish
solarflare koi
spectral seamoth
spfin shark
sporeback sturgeon
starlight manta ray
steamforged whale
steamwork sawfish
stormcaller hammerhead
stormfrill axolotl
strippled seahorse
sunpiercer swordfish
thunder manta ray
thunder squid
]],

    Secret = [[
1x1x1x1 comet shark
ancient lochness monster
ancient whale
armored shark
ashen kingfish
big crystal goliath
big king jelly
blob shark
blocky lochness monster
bloodmoon whale
bone whale
coral reaper
cryoshade glider
crystal crab
dark megalodon
dead zombie shark
depthseeker ray
eerie shark
elemental tempest ray
elretro gran maja
elshark gran maja
emerald winter whale
frost moon whale
frostborn shark
ghost shark
ghost worm fish
giant squid
gigabyte
glacial serpent
gladiator shark
grand maja
great whale
hacker shark
heartbreak nessie
icebreaker whale
jellybeam
king crab
king jelly
kraken
krampus shark
lochness monster
megalodon
midnight blue wildes shark
monster shark
mosasaur shark
orca
panther eel
queen crab
retro maja
robot kraken
scare
skeleton narwhal
sky blue talon shark
soulveil koi
spiritborn axolotl
strawberry choc megalodon
talon serpent
vineyard kraken
winter frost shark
worm fish
zombie megalodon
zombie shark
ancient magma whale
caustic maw
coral whale
cosmic mutant shark
cryoshade gilder
crystal goliath
cursed kraken
dawnbringer betta
deepsea monster axolotl
dephseeker ray
elemental tempestray
elpirate gran maja
frostmoon whale
jelly beam
mossaurus shark
pelagon
pirate megalodon
riftborn arowana
runic enchant stone
thin armor shark
tribunal withering core
viridis luker
withering core
]],

    Forgotten = [[
elemental hydra
flame tyrant
frostbite leviathan
iridesca
soulwake express
trench warden
cerulean dragon
crimson dreadtusk
everbloom
fluorivane
overlord hydra
ragnarex
scorching veinmaw
sea eater
seraphyrion
thunderzilla
]],
}

local function trim(text)
    return text:match("^%s*(.-)%s*$")
end

local function normalize(text)
    return trim(text:lower():gsub("%s+", " "))
end

for rarity, names in pairs(FISH_GROUPS) do
    for name in names:gmatch("[^\r\n]+") do
        local key = normalize(name)
        if key ~= "" then
            FISH_RARITY[key] = rarity
        end
    end
end

local function classifyFish(name)
    return FISH_RARITY[normalize(name)] or "Unknown"
end

-- Legend menggunakan nama internal Legendary.
local RARITY_ORDER = {
    "Legendary",
    "Mythic",
    "Secret",
    "Forgotten",
}

local selectedRarities = {}
for _, rarity in ipairs(RARITY_ORDER) do
    selectedRarities[rarity] = true
end

local MUTATIONS = {
    "8-Bit",
    "Abyssal",
    "Albino",
    "Arctic Frost",
    "Aurora",
    "Binary",
    "Bloodmoon",
    "Color Burn",
    "Corrupt",
    "Cosmic",
    "Crystallized",
    "Disco",
    "Duskbreaker",
    "Elemental",
    "Fairy Dust",
    "Festive",
    "Frozen",
    "Galaxy",
    "Gemstone",
    "Ghost",
    "Glitch",
    "Gold",
    "Golden",
    "Haunted",
    "Holographic",
    "Leviathan's Rage",
    "Lightning",
    "Midnight",
    "Moon Fragment",
    "Noob",
    "Radioactive",
    "Sandy",
    "Solar",
    "Stone",
}

table.sort(MUTATIONS, function(a, b)
    return #a > #b
end)

local function expandNumber(text)
    local number, suffix = text:match("^([%d%.]+)([KkMmBb]?)$")
    number = tonumber(number)

    if not number then
        return nil
    end

    local multipliers = {
        K = 1000,
        M = 1000000,
        B = 1000000000,
    }

    return number * (multipliers[suffix:upper()] or 1)
end

local function parseCatch(message)
    local plain = message:gsub("<[^>]+>", "")

    local playerName, details, weight, rarity = plain:match(
        "(%S+)%s+obtained%s+(.+)%s+%(([^()]+)%)"
        .. "%s+with%s+a%s+1%s+in%s+([%d%.]+[KkMmBb]?)"
    )

    -- Format item tanpa berat.
    if not playerName then
        playerName, details, rarity = plain:match(
            "(%S+)%s+obtained%s+(.+)%s+with%s+a%s+1%s+in%s+([%d%.]+[KkMmBb]?)"
        )
    end

    if not playerName then
        return nil
    end

    details = trim(details)

    if details:sub(1, 3):lower() == "an " then
        details = trim(details:sub(4))
    elseif details:sub(1, 2):lower() == "a " then
        details = trim(details:sub(3))
    end

    local mutation
    local big = false
    local shiny = false

    while details ~= "" do
        local lowered = details:lower()
        local matched = false

        if lowered:sub(1, 4) == "big " then
            big = true
            details = trim(details:sub(5))
            matched = true

        elseif lowered:sub(1, 6) == "shiny " then
            shiny = true
            details = trim(details:sub(7))
            matched = true

        else
            -- Pertahankan nama ikan asli yang sudah dikenal.
            if classifyFish(details) ~= "Unknown" then
                break
            end

            for _, name in ipairs(MUTATIONS) do
                local prefix = name:lower() .. " "

                if lowered:sub(1, #prefix) == prefix then
                    mutation = name
                    details = trim(details:sub(#prefix + 1))
                    matched = true
                    break
                end
            end
        end

        if not matched then
            break
        end
    end

    if details == "" then
        return nil
    end

    local weightNumber = weight and trim(weight):match(
        "^([%d%.]+[KkMmBb]?)%s*[Kk][Gg]$"
    )

    return {
        player_name = playerName,
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

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")

local player = Players.LocalPlayer
if not player then
    error("[Fish Logger] Jalankan dari sisi pemain/client.")
end

local playerGui = player:WaitForChild("PlayerGui", 15)
if not playerGui then
    error("[Fish Logger] PlayerGui tidak tersedia.")
end

local oldGui = playerGui:FindFirstChild("FishCatchLoggerPanel")
if oldGui then
    oldGui:Destroy()
end

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
title.Text = "fish logger | 4 rarity + mutasi"
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

local saveFile = "fish_logger_webhook_settings.json"
local autoSaveUrl = false
local persistenceReady = type(readfile) == "function"
    and type(writefile) == "function"

local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(1, -12, 0, 34)
saveButton.TextColor3 = Color3.new(1, 1, 1)
saveButton.TextSize = 14
ordered(saveButton)

local saveNotice = label(
    "Auto-save hanya menyimpan URL; koneksi dan kirim tetap OFF saat mulai."
)

local function refreshSaveButton()
    saveButton.Text = "Auto-save URL: "
        .. (autoSaveUrl and "ON" or "OFF")

    saveButton.BackgroundColor3 = autoSaveUrl
        and Color3.fromRGB(35, 112, 78)
        or Color3.fromRGB(130, 52, 52)
end

local function persistUrl()
    if not persistenceReady then
        return false
    end

    return pcall(function()
        writefile(saveFile, HttpService:JSONEncode({
            auto_save = autoSaveUrl,
            url = autoSaveUrl and trim(urlBox.Text) or "",
        }))
    end)
end

-- Muat URL hanya jika sebelumnya auto-save diaktifkan.
if persistenceReady then
    local ok, saved = pcall(function()
        return HttpService:JSONDecode(readfile(saveFile))
    end)

    if ok
        and type(saved) == "table"
        and saved.auto_save == true
        and type(saved.url) == "string" then

        autoSaveUrl = true
        urlBox.Text = saved.url
        saveNotice.Text = "URL lokal dimuat. Koneksi dan kirim tetap OFF."
    end
else
    saveNotice.Text =
        "Auto-save tidak tersedia: readfile/writefile tidak didukung."
end

refreshSaveButton()

saveButton.Activated:Connect(function()
    if not persistenceReady then
        saveNotice.Text =
            "Tidak bisa auto-save di lingkungan ini. URL hanya ada di memori sesi."
        return
    end

    if not autoSaveUrl then
        local url = trim(urlBox.Text)

        if not url:match("^https://[^%s]+$") then
            saveNotice.Text =
                "Isi URL HTTPS yang valid sebelum mengaktifkan auto-save."
            return
        end
    end

    local previous = autoSaveUrl
    autoSaveUrl = not autoSaveUrl

    if not persistUrl() then
        autoSaveUrl = previous
        refreshSaveButton()
        saveNotice.Text =
            "Gagal menyimpan pengaturan. Status tidak diubah; file lama mungkin masih ada."
        return
    end

    refreshSaveButton()

    saveNotice.Text = autoSaveUrl
        and "ON: URL disimpan lokal sebagai teks biasa. Hindari perangkat bersama."
        or "OFF: URL dikosongkan dari file pengaturan; URL panel tetap untuk sesi ini."
end)

local saveVersion = 0

urlBox:GetPropertyChangedSignal("Text"):Connect(function()
    saveVersion = saveVersion + 1
    local version = saveVersion

    if not autoSaveUrl then
        return
    end

    task.delay(0.6, function()
        if version ~= saveVersion
            or not autoSaveUrl
            or not gui.Parent then
            return
        end

        local url = trim(urlBox.Text)

        if url == "" or url:match("^https://[^%s]+$") then
            if persistUrl() then
                saveNotice.Text =
                    "URL lokal diperbarui. Pengiriman tetap dikendalikan tombol kirim."
            else
                saveNotice.Text =
                    "Gagal memperbarui URL lokal; file mungkin masih berisi URL sebelumnya."
            end
        else
            saveNotice.Text =
                "URL belum valid; file lokal belum diperbarui."
        end
    end)
end)

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
    local displayName = key == "Legendary" and "legend" or key:lower()

    local filter = Instance.new("TextButton")
    filter.LayoutOrder = index
    filter.TextColor3 = Color3.new(1, 1, 1)
    filter.TextSize = 14
    filter.TextWrapped = true
    filter.Parent = filters

    local function refresh()
        filter.Text = displayName
            .. (selectedRarities[key] and " : on" or " : off")

        filter.BackgroundColor3 = selectedRarities[key]
            and Color3.fromRGB(35, 112, 78)
            or Color3.fromRGB(66, 66, 73)
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
local lastLabel = label("Belum ada tangkapan yang terbaca.")

label("Filter hanya untuk 4 rarity di atas; tangkapan Unknown tetap diteruskan.")

local function setDeliveryStatus(text)
    if deliveryLabel.Parent then
        deliveryLabel.Text = "Webhook: " .. text
    end
end

local function setStatus(text)
    if statusLabel.Parent then
        statusLabel.Text = text
    end
end

local function resizePanel()
    local camera = workspace.CurrentCamera

    if camera then
        local size = camera.ViewportSize

        frame.Size = UDim2.fromOffset(
            math.min(340, math.max(180, size.X - 24)),
            math.min(300, math.max(130, size.Y - 48))
        )
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
    if type(request) == "function" then
        return request
    end

    if type(http_request) == "function" then
        return http_request
    end

    if type(syn) == "table" and type(syn.request) == "function" then
        return syn.request
    end

    return nil
end

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
        setDeliveryStatus(
            "Sedang mengirim. Pesan ini tidak dikirim; tidak ada antrean."
        )
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
        if disposed
            or not masterEnabled
            or generation ~= stoppedGeneration then
            sending = false
            return
        end

        local ok, response = pcall(function()
            return sendRequest({
                Url = url,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                },
                Body = HttpService:JSONEncode(
                    catchPayload or { content = content }
                ),
            })
        end)

        sending = false

        if disposed
            or not masterEnabled
            or generation ~= stoppedGeneration then
            return
        end

        if not ok then
            setDeliveryStatus(
                "Request gagal. URL disembunyikan; periksa koneksi/endpoint."
            )
            return
        end

        local code = type(response) == "table"
            and tonumber(response.StatusCode or response.Status)
            or nil

        if code and code >= 200 and code < 300 then
            if isTest then
                setDeliveryStatus(
                    "Tes diterima HTTP "
                    .. code
                    .. ". Cek rekap web sebelum mengaktifkan otomatis."
                )
            else
                setDeliveryStatus("Diterima HTTP " .. code .. ".")
            end
        else
            setDeliveryStatus(
                "Belum berhasil. HTTP: "
                .. tostring(code or "tidak diketahui")
                .. ". Cek format API."
            )
        end
    end)
end

testButton.Activated:Connect(function()
    local url, err = readUrl()

    if not url then
        setStatus(err)
        return
    end

    postContent(
        url,
        "[TEST] Fish Catch Logger: tes koneksi, bukan tangkapan ikan.",
        true
    )
end)

toggleButton.Activated:Connect(function()
    if not masterEnabled then
        setStatus("Aktifkan koneksi utama dulu.")
        return
    end

    if enabled then
        stoppedGeneration = stoppedGeneration + 1
        enabled = false
        activeUrl = nil
        updateSendButton(false)

        setStatus(
            "Pengiriman berikutnya dinonaktifkan. "
            .. "Request yang berjalan tidak dibatalkan."
        )
        return
    end

    local url, err = readUrl()

    if not url then
        setStatus(err)
        return
    end

    if not transport() then
        setStatus("Fungsi HTTP request tidak tersedia.")
        return
    end

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
    if disposed or not masterEnabled then
        return
    end

    local rarityCategory = classifyFish(catch.fish_name)

    if rarityCategory ~= "Unknown"
        and not selectedRarities[rarityCategory] then
        setStatus(
            "Tangkapan dilewati oleh filter rarity: " .. rarityCategory
        )
        return
    end

    lastLabel.Text = catch.player_name
        .. " | " .. catch.fish_name
        .. " | " .. rarityCategory
        .. " | mutasi: " .. (catch.mutation or "-")
        .. " | " .. (catch.weight_raw or "tanpa berat")
        .. " | " .. catch.rarity_raw

    if enabled and activeUrl then
        local payload = makeCatchPayload(catch, rarityCategory)
        postContent(activeUrl, catch.raw_message, false, payload)
    else
        setStatus("Tangkapan terbaca. Pengiriman otomatis masih OFF.")
    end
end

if _G[connectionKey] then
    pcall(function()
        _G[connectionKey]:Disconnect()
    end)

    _G[connectionKey] = nil
end

local function disconnectListener()
    if connection then
        local old = connection
        connection = nil
        old:Disconnect()

        if _G[connectionKey] == old then
            _G[connectionKey] = nil
        end
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

    setStatus(
        "OFF: listener terputus. "
        .. "Request yang sudah terkirim tidak dapat ditarik."
    )
end

local function startMain()
    if disposed or masterEnabled then
        return
    end

    local ok, result = pcall(function()
        return TextChatService.MessageReceived:Connect(function(message)
            if disposed or not masterEnabled then
                return
            end

            local text = message.Text

            if type(text) ~= "string" then
                return
            end

            local catch = parseCatch(text)

            if catch then
                sendCatch(catch)
            end
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
    if masterEnabled then
        stopMain()
    else
        startMain()
    end
end)

gui.Destroying:Connect(function()
    disposed = true
    stopMain()
end)

setStatus("Koneksi utama OFF. Aktifkan untuk membaca pesan baru.")

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
restoreButton.Size = UDim2.fromOffset(40, 40)
restoreButton.Position = UDim2.new(0, 10, 0.5, -20)
restoreButton.BackgroundColor3 = Color3.fromRGB(245, 246, 250)
restoreButton.BackgroundTransparency = 0.08
restoreButton.BorderSizePixel = 0
restoreButton.TextColor3 = Color3.fromRGB(25, 25, 30)
restoreButton.TextSize = 28
restoreButton.Text = "🐼"
restoreButton.ZIndex = 10
restoreButton.Visible = false
restoreButton.Parent = gui

local pandaCorner = Instance.new("UICorner")
pandaCorner.CornerRadius = UDim.new(1, 0)
pandaCorner.Parent = restoreButton

local pandaOutline = Instance.new("UIStroke")
pandaOutline.Color = Color3.fromRGB(210, 214, 225)
pandaOutline.Thickness = 1
pandaOutline.Parent = restoreButton

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
