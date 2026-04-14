//
//  CulturalQuestionData.swift
//  135SokanmocrexFlengel
//

import Foundation

enum CulturalQuestionData {
    static func items(for level: Int) -> [TriviaItem] {
        switch level {
        case 1: return level1
        case 2: return level2
        case 3: return level3
        case 4: return level4
        case 5: return level5
        case 6: return level6
        case 7: return level7
        case 8: return level8
        case 9: return level9
        case 10: return level10
        case 11: return level11
        case 12: return level12
        default: return level1
        }
    }

    private static let level1: [TriviaItem] = [
        TriviaItem(id: "cc1a", prompt: "Diwali is widely associated with rows of lamps and is prominent in which cultural sphere?", options: ["Nordic midsummer", "South Asian traditions", "Pacific voyaging", "Andean weaving"], correctIndex: 1, explanation: "It is celebrated by many Hindu, Sikh, and Jain communities worldwide.", hint: "Think of festivals of lights in India."),
        TriviaItem(id: "cc1b", prompt: "The Japanese tea ceremony emphasizes mindfulness and respect around serving what?", options: ["Sake", "Matcha", "Barley tea", "Black tea"], correctIndex: 1, explanation: "Powdered green tea is whisked with hot water in a choreographed ritual.", hint: "Bright green powdered drink."),
        TriviaItem(id: "cc1c", prompt: "Carnival before Lent features parades and masks strongly tied to which city?", options: ["Lyon", "Venice", "Munich", "Porto"], correctIndex: 1, explanation: "Historic masquerade balls and water processions define its style.", hint: "City of canals in northeastern Italy."),
        TriviaItem(id: "cc1d", prompt: "Thanksgiving in the United States is traditionally marked by gatherings centered on what meal?", options: ["Roast lamb", "Turkey dinner", "Sushi platters", "Taco buffet"], correctIndex: 1, explanation: "Harvest gratitude narratives shaped the modern holiday.", hint: "Large poultry bird."),
        TriviaItem(id: "cc1e", prompt: "Mariachi bands with trumpets and violins are strongly associated with which country?", options: ["Brazil", "Mexico", "Cuba", "Argentina"], correctIndex: 1, explanation: "The style became an emblem of regional pride and celebration.", hint: "North of Guatemala."),
    ]

    private static let level2: [TriviaItem] = [
        TriviaItem(id: "cc2a", prompt: "Holi, known for colored powders, is celebrated widely in connection with which region?", options: ["North Africa", "South Asia", "Scandinavia", "Siberia"], correctIndex: 1, explanation: "Spring festivals of color occur in many communities globally now.", hint: "Shares roots with Diwali region."),
        TriviaItem(id: "cc2b", prompt: "The Highland Games feature caber toss and bagpipes tied to which country?", options: ["Ireland", "Scotland", "Wales", "Iceland"], correctIndex: 1, explanation: "Clan gatherings and athletic contests define the tradition.", hint: "North of England, part of the UK."),
        TriviaItem(id: "cc2c", prompt: "Hanami picnics under blooming trees are a spring tradition in which country?", options: ["South Korea", "Japan", "Vietnam", "Mongolia"], correctIndex: 1, explanation: "Cherry blossoms draw crowds to parks and riverbanks.", hint: "Island nation east of the Asian mainland."),
        TriviaItem(id: "cc2d", prompt: "Tapas-style small plates are a social dining tradition most linked to which country?", options: ["Portugal", "Spain", "France", "Italy"], correctIndex: 1, explanation: "Sharing bites with drinks is common in the evening.", hint: "Iberian peninsula, not Portugal."),
        TriviaItem(id: "cc2e", prompt: "The Maasai are known for beadwork and jumping dances in which part of the world?", options: ["West African coast", "East African savanna", "Central rainforest", "Southern desert"], correctIndex: 1, explanation: "Pastoral communities live near national parks and rift valleys.", hint: "Kenya and Tanzania."),
    ]

    private static let level3: [TriviaItem] = [
        TriviaItem(id: "cc3a", prompt: "Nowruz marks a new year at the spring equinox with roots in which broader cultural area?", options: ["Mesoamerica", "Persianate worlds", "Polynesia", "Siberian shamanism"], correctIndex: 1, explanation: "Haft-sin tables and house cleaning accompany the holiday.", hint: "Think Iran and neighboring traditions."),
        TriviaItem(id: "cc3b", prompt: "Samba schools parading during Carnival are iconic in which city?", options: ["Buenos Aires", "Rio de Janeiro", "Havana", "Lima"], correctIndex: 1, explanation: "Sambódromo parades draw global audiences.", hint: "Same country as Christ the Redeemer."),
        TriviaItem(id: "cc3c", prompt: "Aboriginal dot painting traditions are most associated with which continent's First Peoples?", options: ["Africa", "Australia", "North America", "Europe"], correctIndex: 1, explanation: "Desert communities share stories through symbolic patterns.", hint: "Great Barrier Reef country."),
        TriviaItem(id: "cc3d", prompt: "The Day of the Dead honors ancestors with altars and marigolds primarily in which nation?", options: ["Guatemala", "Mexico", "Colombia", "Peru"], correctIndex: 1, explanation: "UNESCO recognizes related intangible heritage.", hint: "South of the United States."),
        TriviaItem(id: "cc3e", prompt: "Kimono layering and obi sashes belong to traditional dress of which culture?", options: ["Korean hanbok", "Japanese attire", "Vietnamese ao dai", "Thai chut thai"], correctIndex: 1, explanation: "Seasonal motifs and tying styles signal formality.", hint: "Kyoto geisha districts showcase refined versions."),
    ]

    private static let level4: [TriviaItem] = [
        TriviaItem(id: "cc4a", prompt: "The Running of the Bulls is most famous in which Spanish city?", options: ["Madrid", "Pamplona", "Bilbao", "Valencia"], correctIndex: 1, explanation: "San Fermín festival fills July mornings with encierro routes.", hint: "Navarre's capital."),
        TriviaItem(id: "cc4b", prompt: "Inuit throat singing developed as a vocal game often between partners in which region?", options: ["Sahara trade routes", "Arctic communities", "Himalayan monasteries", "Amazon river towns"], correctIndex: 1, explanation: "Competitive duets imitate nature sounds.", hint: "Cold northern latitudes."),
        TriviaItem(id: "cc4c", prompt: "The whirling dervish ceremony is linked to Sufi practice most associated with which city?", options: ["Cairo", "Konya", "Isfahan", "Marrakesh"], correctIndex: 1, explanation: "Mevlana Rumi's tomb draws pilgrims.", hint: "Central Anatolia in Türkiye."),
        TriviaItem(id: "cc4d", prompt: "The Aboriginal didgeridoo is a long wooden drone instrument from which country?", options: ["New Zealand", "Australia", "Papua New Guinea", "Fiji"], correctIndex: 1, explanation: "Northern traditions use termite-hollowed branches.", hint: "Same continent as Uluru."),
        TriviaItem(id: "cc4e", prompt: "La Tomatina is a massive food fight with tomatoes held near which Spanish town?", options: ["Buñol", "Seville", "Granada", "Salamanca"], correctIndex: 0, explanation: "Valencia province hosts the messy August event.", hint: "Small town name starting with B."),
    ]

    private static let level5: [TriviaItem] = [
        TriviaItem(id: "cc5a", prompt: "The Inti Raymi festival revives Incan sun worship near which city?", options: ["La Paz", "Cusco", "Quito", "Sucre"], correctIndex: 1, explanation: "Winter solstice rites occur in the former imperial capital.", hint: "Gateway to Machu Picchu."),
        TriviaItem(id: "cc5b", prompt: "Griot storytellers preserving oral history through music are traditional in which region?", options: ["Andes highlands", "West Africa", "Baltic coast", "Caucasus mountains"], correctIndex: 1, explanation: "Historians and praise-singers accompany kora or balafon.", hint: "Mali, Senegal, Guinea area."),
        TriviaItem(id: "cc5c", prompt: "The Songkran festival involves water splashing as a new year celebration in which country?", options: ["Indonesia", "Thailand", "Philippines", "Malaysia"], correctIndex: 1, explanation: "April streets turn into playful water battles.", hint: "Bangkok is the capital."),
        TriviaItem(id: "cc5d", prompt: "The Aboriginal Welcome to Country acknowledges whose land at events in Australia?", options: ["British Crown only", "Traditional custodians", "United Nations", "City mayors"], correctIndex: 1, explanation: "Protocols recognize ongoing Indigenous connection to place.", hint: "First Nations hosts."),
        TriviaItem(id: "cc5e", prompt: "The Quinceañera celebration marks a fifteenth birthday in many Latin communities with what focus?", options: ["Graduation", "Transition to young adulthood", "Retirement", "Wedding rehearsal"], correctIndex: 1, explanation: "Masses, dances, and family gatherings highlight the milestone.", hint: "Fifteen years old."),
    ]

    private static let level6: [TriviaItem] = [
        TriviaItem(id: "cc6a", prompt: "A traditional Ethiopian meal often shares injera flatbread from a communal platter, emphasizing what value?", options: ["Speed eating", "Hospitality and togetherness", "Silent dining", "Individual portions only"], correctIndex: 1, explanation: "Tearing pieces of spongy bread to scoop stews is a social ritual.", hint: "Think shared basket."),
        TriviaItem(id: "cc6b", prompt: "Sunday roast with Yorkshire pudding is a classic meal stereotype of which country?", options: ["France", "United Kingdom", "Italy", "Portugal"], correctIndex: 1, explanation: "Pub carveries and family dinners popularized the tradition.", hint: "London, Edinburgh, Cardiff."),
        TriviaItem(id: "cc6c", prompt: "Pierogi dumplings stuffed with potato or cheese are staples in which European regional cuisine?", options: ["Scandinavia only", "Central and Eastern Europe", "Iberia only", "Balkans only"], correctIndex: 1, explanation: "Poland, Ukraine, and neighbors each claim beloved variants.", hint: "Think Warsaw or Kyiv kitchens."),
        TriviaItem(id: "cc6d", prompt: "Bubble tea originated in Taiwan and blends tea with chewy pearls made mainly from what?", options: ["Rice flour", "Tapioca starch", "Cornmeal", "Wheat gluten"], correctIndex: 1, explanation: "Dark tapioca balls sit at the bottom of the drink.", hint: "Cassava-derived starch."),
        TriviaItem(id: "cc6e", prompt: "Mezze-style small dishes—hummus, tabbouleh, grilled meats—are typical of which broad culinary region?", options: ["Nordic", "Eastern Mediterranean and Levant", "Andean", "Siberian"], correctIndex: 1, explanation: "Shared plates encourage long social meals.", hint: "Beirut, Damascus, Amman flavors."),
    ]

    private static let level7: [TriviaItem] = [
        TriviaItem(id: "cc7a", prompt: "Flamenco guitar, song, and dance crystallized in southern Spain within which regional culture?", options: ["Basque Country", "Andalusia", "Galicia", "Catalonia"], correctIndex: 1, explanation: "Gitano and Andalusian artists shaped the tablaos tradition.", hint: "Seville, Granada, Córdoba."),
        TriviaItem(id: "cc7b", prompt: "The polyrhythms of West African drumming underpin many traditions that crossed the Atlantic during which era?", options: ["Roman expansion", "Transatlantic forced migration", "Mongol conquests", "Viking raids"], correctIndex: 1, explanation: "Enslaved peoples preserved musical patterns that influenced new genres.", hint: "Middle Passage context."),
        TriviaItem(id: "cc7c", prompt: "Tango music and dance matured in the late 19th century around the Río de la Plata in Argentina and where else?", options: ["Chile", "Uruguay", "Paraguay", "Bolivia"], correctIndex: 1, explanation: "Montevideo and Buenos Aires both nurtured milongas.", hint: "Small country east of Argentina."),
        TriviaItem(id: "cc7d", prompt: "Gamelan orchestras of bronze keyed instruments are central to court and village music in which archipelago nation?", options: ["Philippines", "Indonesia", "Madagascar", "Japan"], correctIndex: 1, explanation: "Bali and Java host intricate cyclical pieces.", hint: "Jakarta is the capital."),
        TriviaItem(id: "cc7e", prompt: "The waltz began as a couples dance in which European region before spreading to ballrooms?", options: ["Iberia", "German-speaking Central Europe", "Balkans only", "Ireland"], correctIndex: 1, explanation: "Vienna later became synonymous with the triple-meter style.", hint: "Think Strauss era associations."),
    ]

    private static let level8: [TriviaItem] = [
        TriviaItem(id: "cc8a", prompt: "The sari is an unstitched draped garment most associated with women's dress in which country?", options: ["China", "India", "Turkey", "Nigeria"], correctIndex: 1, explanation: "Regional draping styles vary by state and occasion.", hint: "Diwali celebrations often showcase vibrant silks."),
        TriviaItem(id: "cc8b", prompt: "Scottish tartan kilts today symbolize clan heritage though historic Highland dress was once restricted after which rebellion?", options: ["1688 Glorious Revolution", "1745 Jacobite rising", "1815 Napoleonic wars", "1848 Springtime"], correctIndex: 1, explanation: "Dress bans followed Culloden before romantic revival.", hint: "Bonnie Prince Charlie's era."),
        TriviaItem(id: "cc8c", prompt: "The huipil woven blouse remains everyday wear for many Indigenous women in southern Mexico and where?", options: ["Argentina", "Guatemala", "Cuba", "Venezuela"], correctIndex: 1, explanation: "Maya communities maintain backstrap loom patterns.", hint: "Country northwest of El Salvador."),
        TriviaItem(id: "cc8d", prompt: "The keffiyeh checkered scarf functions as sun and sand protection and carries cultural weight across which region?", options: ["Andes", "Middle East", "Siberia", "Caribbean"], correctIndex: 1, explanation: "Palestinian and Bedouin styles influenced global fashion.", hint: "Desert and Levant contexts."),
        TriviaItem(id: "cc8e", prompt: "The ao dai long tunic over trousers is a national costume icon of which country?", options: ["Thailand", "Vietnam", "Cambodia", "Laos"], correctIndex: 1, explanation: "Tailored silk versions appear at Tet and weddings.", hint: "Hanoi and Ho Chi Minh City."),
    ]

    private static let level9: [TriviaItem] = [
        TriviaItem(id: "cc9a", prompt: "Capoeira blends dance, music, and acrobatic sparring and emerged among Afro-Brazilian communities as a form of what?", options: ["Colonial court dance", "Disguised resistance and expression", "Olympic training only", "Religious penance only"], correctIndex: 1, explanation: "The berimbau sets rhythm in the roda circle.", hint: "Salvador, Bahia links."),
        TriviaItem(id: "cc9b", prompt: "Kabaddi, a tag-and-hold team sport with breath-holding chants, is especially popular on the subcontinent of where?", options: ["Africa", "South Asia", "Scandinavia", "Oceania"], correctIndex: 1, explanation: "India, Bangladesh, and neighbors host pro leagues.", hint: "Think India and neighbors."),
        TriviaItem(id: "cc9c", prompt: "The Tour de France cycling race is culturally tied to which country despite international riders?", options: ["Belgium", "France", "Italy", "Spain"], correctIndex: 1, explanation: "Champagne toasts and roadside fans mark July stages.", hint: "Arc de Triomphe finishes."),
        TriviaItem(id: "cc9d", prompt: "Sumo tournaments in Japan begin with Shinto-style purification and wrestlers belong to professional what?", options: ["Guilds called stables", "Stables called heya", "Monasteries only", "Universities only"], correctIndex: 1, explanation: "Heya life governs training, rank, and dress.", hint: "Japanese word for stable."),
        TriviaItem(id: "cc9e", prompt: "Hurling, played with ash sticks and a small ball, is an ancient field game protected as heritage in which country?", options: ["Scotland", "Ireland", "Wales", "Iceland"], correctIndex: 1, explanation: "The Gaelic Athletic Association promotes it alongside Gaelic football.", hint: "Dublin's Croke Park."),
    ]

    private static let level10: [TriviaItem] = [
        TriviaItem(id: "cc10a", prompt: "Epic poems like the Mahabharata were transmitted for centuries in South Asia primarily through what means?", options: ["Only printed books", "Oral recitation and performance", "Silent manuscripts only", "Telegraph codes"], correctIndex: 1, explanation: "Bards and priests memorized vast Sanskrit narratives.", hint: "Listeners gathered at courts and temples."),
        TriviaItem(id: "cc10b", prompt: "Homeric epics about Troy were composed in which ancient poetic dialect?", options: ["Latin", "Ancient Greek", "Sanskrit", "Coptic"], correctIndex: 1, explanation: "Dactylic hexameter carried the Iliad and Odyssey.", hint: "Athens later dramatized these myths."),
        TriviaItem(id: "cc10c", prompt: "Arabian Nights frame stories blend Persian, Indian, and Arab motifs and spread widely through what medium?", options: ["Only cinema", "Manuscript anthologies and oral telling", "Radio alone", "Internet alone"], correctIndex: 1, explanation: "Scheherazade's tales circulated across trade routes.", hint: "Thousand and one nights."),
        TriviaItem(id: "cc10d", prompt: "West African griots combine genealogy, praise poetry, and music while serving as what for communities?", options: ["Silent scribes only", "Living historians and advisors", "Colonial officers", "Anonymous laborers"], correctIndex: 1, explanation: "Mandé jelis preserve lineages with kora accompaniment.", hint: "Praise-singers at ceremonies."),
        TriviaItem(id: "cc10e", prompt: "Calypso in Trinidad often carried social commentary and spread on plantations through what linguistic blend?", options: ["Only French", "English-based Creole and African rhythms", "Only Spanish", "Only Dutch"], correctIndex: 1, explanation: "Steelpan later amplified carnival culture.", hint: "Caribbean English Creole."),
    ]

    private static let level11: [TriviaItem] = [
        TriviaItem(id: "cc11a", prompt: "Mudhif reed houses built by Marsh Arabs arch dramatically in the wetlands of which river system?", options: ["Amazon", "Tigris–Euphrates", "Nile delta", "Mekong"], correctIndex: 1, explanation: "Bundled reeds create guest halls supported by bundled columns.", hint: "Southern Iraq marshes."),
        TriviaItem(id: "cc11b", prompt: "Yurts or gers are portable felt dwellings still used by pastoral herders on which high plateau?", options: ["Tibet", "Mongolian steppe", "Ethiopian highlands", "Patagonia"], correctIndex: 1, explanation: "Circular lattice walls and crown wheels withstand winds.", hint: "Ulaanbaatar is the capital."),
        TriviaItem(id: "cc11c", prompt: "Pueblo multi-story adobe apartments in the U.S. Southwest reflect Indigenous farming along seasonal what?", options: ["Monsoon floods", "Arroyo flash rains", "Glacier melt only", "Tidal bores"], correctIndex: 1, explanation: "Cliff and mesa villages conserve heat in desert nights.", hint: "New Mexico iconic sites."),
        TriviaItem(id: "cc11d", prompt: "Stilt houses over water help fishing communities cope with tides in Southeast Asia and also where?", options: ["Sahara oases", "Pacific islands like Vanuatu", "Swiss lakes", "Siberian taiga"], correctIndex: 1, explanation: "Coral and mangrove coasts favor raised floors.", hint: "Melanesian archipelago example."),
        TriviaItem(id: "cc11e", prompt: "Trulli conical stone huts with whitewashed symbols dot the countryside of which Italian region?", options: ["Tuscany", "Apulia (Puglia)", "Sicily", "Lombardy"], correctIndex: 1, explanation: "Dry-stacked limestone cones historically eased tax evasion by quick dismantling.", hint: "Alberobello town."),
    ]

    private static let level12: [TriviaItem] = [
        TriviaItem(id: "cc12a", prompt: "In Japan, exchanging meishi business cards is done with both hands and immediate reading signals what?", options: ["Disinterest", "Respect and attention", "Haste to finish", "Refusal to meet"], correctIndex: 1, explanation: "Cards are treated as extensions of the person.", hint: "Never pocket instantly in front of giver."),
        TriviaItem(id: "cc12b", prompt: "Cheek kissing as a greeting varies by country; in many Middle Eastern and Mediterranean cultures, same-gender friends may greet more openly than what?", options: ["Opposite-gender public greetings", "Children", "Elders", "Shopkeepers"], correctIndex: 0, explanation: "Conservative norms may limit cross-gender physical greetings in public.", hint: "Gendered public modesty norms."),
        TriviaItem(id: "cc12c", prompt: "Removing shoes before entering homes is expected across much of East and Southeast Asia and also where?", options: ["Only Canada", "Scandinavia and parts of Northern Europe", "Brazil only", "South Africa only"], correctIndex: 1, explanation: "Keeping interiors clean motivates the habit in snowy and rainy climates too.", hint: "Think wooden floors and socks."),
        TriviaItem(id: "cc12d", prompt: "The 'Irish goodbye' slang means leaving a gathering how?", options: ["With a long speech", "Quietly without formal farewells", "Only after sunrise", "Only if music stops"], correctIndex: 1, explanation: "Slipping out avoids interrupting hosts in crowded parties.", hint: "Ghosting the room."),
        TriviaItem(id: "cc12e", prompt: "In many cultures, pointing soles of feet toward someone is rude because feet are considered what?", options: ["Sacred relics", "Lowest and unclean", "Royal insignia", "Musical instruments"], correctIndex: 1, explanation: "Temples and living rooms in Thailand and neighbors stress polite sitting posture.", hint: "Avoid foot-forward toward elders."),
    ]
}
