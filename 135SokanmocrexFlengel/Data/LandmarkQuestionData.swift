//
//  LandmarkQuestionData.swift
//  135SokanmocrexFlengel
//

import Foundation

enum LandmarkQuestionData {
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
        TriviaItem(id: "lm1a", prompt: "Which city is home to a famous tower made of iron lattice built for an 1889 world exposition?", options: ["London", "Paris", "Berlin", "Rome"], correctIndex: 1, explanation: "The structure was completed as the entrance arch for the exposition and became a lasting city symbol.", hint: "Think of the capital of France."),
        TriviaItem(id: "lm1b", prompt: "The ancient Colosseum is located in which country?", options: ["Greece", "Italy", "Spain", "Turkey"], correctIndex: 1, explanation: "This oval amphitheater was built in the capital of the Roman Empire.", hint: "The city is nicknamed the Eternal City."),
        TriviaItem(id: "lm1c", prompt: "Which wall in northern China was built and rebuilt over centuries for defense?", options: ["Hadrian's Wall", "Great Wall", "Western Wall", "Berlin Wall"], correctIndex: 1, explanation: "It stretches across mountains and valleys for thousands of miles.", hint: "It is often visible from low orbit photographs."),
        TriviaItem(id: "lm1d", prompt: "Niagara Falls sits on the border between the United States and which country?", options: ["Mexico", "Canada", "Greenland", "Cuba"], correctIndex: 1, explanation: "The falls are shared by the province of Ontario and the state of New York.", hint: "The neighbor to the north."),
        TriviaItem(id: "lm1e", prompt: "The Taj Mahal is a mausoleum built with white marble in which country?", options: ["Pakistan", "India", "Iran", "Nepal"], correctIndex: 1, explanation: "It stands on the banks of the Yamuna River near Agra.", hint: "South Asian country known for diverse cultures and Bollywood."),
    ]

    private static let level2: [TriviaItem] = [
        TriviaItem(id: "lm2a", prompt: "Christ the Redeemer overlooks which coastal city?", options: ["Lima", "Rio de Janeiro", "Sydney", "Cape Town"], correctIndex: 1, explanation: "The statue stands atop Corcovado mountain.", hint: "Portuguese is widely spoken here."),
        TriviaItem(id: "lm2b", prompt: "The ancient city of Petra is carved into rose-red cliffs in which region?", options: ["Egypt", "Jordan", "Morocco", "Lebanon"], correctIndex: 1, explanation: "It was the capital of the Nabataean kingdom.", hint: "Middle Eastern kingdom east of Israel."),
        TriviaItem(id: "lm2c", prompt: "The Sydney Opera House is famous for its shell-like roofs in which country?", options: ["New Zealand", "Australia", "South Africa", "Fiji"], correctIndex: 1, explanation: "It sits on Bennelong Point in New South Wales.", hint: "Kangaroos are native wildlife here."),
        TriviaItem(id: "lm2d", prompt: "The leaning tower that shares its name with a small Italian town is in which region?", options: ["Sicily", "Tuscany", "Lombardy", "Veneto"], correctIndex: 1, explanation: "The freestanding bell tower tilts because of soft ground.", hint: "Birthplace of Galileo Galilei."),
        TriviaItem(id: "lm2e", prompt: "The ancient Acropolis rises above which European capital?", options: ["Athens", "Madrid", "Vienna", "Dublin"], correctIndex: 0, explanation: "The Parthenon crowns this rocky hill.", hint: "Capital of Greece."),
    ]

    private static let level3: [TriviaItem] = [
        TriviaItem(id: "lm3a", prompt: "Angkor Wat began as a Hindu temple complex in which country?", options: ["Thailand", "Vietnam", "Cambodia", "Laos"], correctIndex: 2, explanation: "It is the largest religious monument in the world by land area.", hint: "Former Khmer Empire heartland."),
        TriviaItem(id: "lm3b", prompt: "The Burj Khalifa, once the tallest building in the world, is in which city?", options: ["Doha", "Dubai", "Abu Dhabi", "Kuwait City"], correctIndex: 1, explanation: "It rises above the downtown district of this emirate.", hint: "Part of the United Arab Emirates."),
        TriviaItem(id: "lm3c", prompt: "Machu Picchu is a 15th-century estate linked to which civilization?", options: ["Aztec", "Maya", "Inca", "Olmec"], correctIndex: 2, explanation: "It sits high in the Andes of Peru.", hint: "Cusco was their imperial capital."),
        TriviaItem(id: "lm3d", prompt: "The Golden Gate Bridge spans a strait next to which U.S. city?", options: ["Los Angeles", "Seattle", "San Francisco", "San Diego"], correctIndex: 2, explanation: "The bridge connects the city to Marin County.", hint: "Fog often rolls in from the Pacific here."),
        TriviaItem(id: "lm3e", prompt: "Stonehenge is a prehistoric stone circle in which part of the United Kingdom?", options: ["Scotland", "Wales", "England", "Northern Ireland"], correctIndex: 2, explanation: "It lies on Salisbury Plain in Wiltshire.", hint: "London is the capital of this constituent country."),
    ]

    private static let level4: [TriviaItem] = [
        TriviaItem(id: "lm4a", prompt: "The Hagia Sophia, a domed marvel, stands in which transcontinental city?", options: ["Cairo", "Istanbul", "Baghdad", "Tehran"], correctIndex: 1, explanation: "It was built in the era of Eastern Roman emperors and later repurposed.", hint: "Straddles Europe and Asia."),
        TriviaItem(id: "lm4b", prompt: "The Sagrada Família basilica, still under construction after more than a century, is in which city?", options: ["Lisbon", "Barcelona", "Madrid", "Valencia"], correctIndex: 1, explanation: "Antoni Gaudí devoted much of his career to the project.", hint: "Capital of Catalonia."),
        TriviaItem(id: "lm4c", prompt: "The Moai statues are associated with which remote island?", options: ["Tahiti", "Easter Island", "Fiji", "Guam"], correctIndex: 1, explanation: "The island is governed by Chile.", hint: "Also called Rapa Nui."),
        TriviaItem(id: "lm4d", prompt: "The Alhambra palace complex overlooks which Spanish city?", options: ["Seville", "Granada", "Córdoba", "Toledo"], correctIndex: 1, explanation: "Nasrid rulers built its famous courtyards and fountains.", hint: "Near the Sierra Nevada mountains in Andalusia."),
        TriviaItem(id: "lm4e", prompt: "The Statue of Liberty was a gift primarily associated with which nation?", options: ["United Kingdom", "France", "Spain", "Netherlands"], correctIndex: 1, explanation: "It was designed by Frédéric Auguste Bartholdi and dedicated in 1886.", hint: "Think of the sculptor's nationality."),
    ]

    private static let level5: [TriviaItem] = [
        TriviaItem(id: "lm5a", prompt: "The rock-hewn churches of Lalibela are a pilgrimage site in which country?", options: ["Kenya", "Ethiopia", "Tanzania", "Sudan"], correctIndex: 1, explanation: "They date to the medieval Zagwe dynasty.", hint: "Only African nation never fully colonized by Europeans."),
        TriviaItem(id: "lm5b", prompt: "The CN Tower was long the tallest free-standing structure in which city?", options: ["Chicago", "Toronto", "Montreal", "Vancouver"], correctIndex: 1, explanation: "It was built for communications and observation.", hint: "Provincial capital of Ontario."),
        TriviaItem(id: "lm5c", prompt: "The ancient city of Chichen Itza features a step pyramid dedicated to which deity tradition?", options: ["Feathered serpent imagery", "Thunder gods only", "Sea spirits only", "Sun disks only"], correctIndex: 0, explanation: "El Castillo aligns with equinox light-and-shadow effects.", hint: "Kukulkan is often depicted as a serpent."),
        TriviaItem(id: "lm5d", prompt: "The Atomium in Brussels represents iron crystals magnified billions of times and was built for which event?", options: ["Olympics 1920", "World's Fair 1958", "Expo 1992", "World Cup 1974"], correctIndex: 1, explanation: "It remains a symbol of postwar optimism and science.", hint: "Mid-1950s international exposition."),
        TriviaItem(id: "lm5e", prompt: "Meteora in Greece is famous for monasteries perched on what formations?", options: ["Volcanic plugs", "Sandstone pillars", "Glacier moraines", "Coral reefs"], correctIndex: 1, explanation: "Hermits first settled the dramatic pinnacles in the medieval era.", hint: "Vertical rock towers."),
    ]

    private static let level6: [TriviaItem] = [
        TriviaItem(id: "lm6a", prompt: "Victoria Falls, a massive curtain of water on the Zambezi River, is mainly associated with which border region?", options: ["Kenya–Tanzania", "Zambia–Zimbabwe", "Botswana–Namibia", "Angola–Congo"], correctIndex: 1, explanation: "Local names include Mosi-oa-Tunya, meaning smoke that thunders.", hint: "Southern Africa, famous bungee nearby."),
        TriviaItem(id: "lm6b", prompt: "Table Mountain overlooks which legislative capital on South Africa's southwest coast?", options: ["Durban", "Cape Town", "Johannesburg", "Port Elizabeth"], correctIndex: 1, explanation: "A flat-topped plateau forms the iconic skyline above the city bowl.", hint: "Robben Island lies offshore here."),
        TriviaItem(id: "lm6c", prompt: "The Great Mosque of Djenné in Mali is famous for its annual replastering festival and what building material?", options: ["Marble blocks", "Mud brick", "Steel frame", "Glass panels"], correctIndex: 1, explanation: "Sudano-Sahelian architecture uses earth and wooden beams.", hint: "Adobe-style West African landmark."),
        TriviaItem(id: "lm6d", prompt: "The Twelve Apostles rock stacks draw visitors along which scenic Australian coastal drive?", options: ["Sunshine Coast", "Great Ocean Road", "Eyre Peninsula", "Tasman Peninsula"], correctIndex: 1, explanation: "Limestone stacks sit beside the Southern Ocean in Victoria.", hint: "Near Port Campbell National Park."),
        TriviaItem(id: "lm6e", prompt: "The Hassan II Mosque, with a tall minaret over the Atlantic, stands in which Moroccan city?", options: ["Fez", "Marrakesh", "Casablanca", "Rabat"], correctIndex: 2, explanation: "It was completed in the 1990s and accommodates vast congregations.", hint: "Largest city on the country's Atlantic coast."),
    ]

    private static let level7: [TriviaItem] = [
        TriviaItem(id: "lm7a", prompt: "Mount Rushmore depicts four U.S. presidents carved into granite in which state?", options: ["Wyoming", "South Dakota", "Montana", "Colorado"], correctIndex: 1, explanation: "Gutzon Borglum led the sculpting in the Black Hills.", hint: "Near Keystone and Crazy Horse memorial."),
        TriviaItem(id: "lm7b", prompt: "The Space Needle was built for a 1962 world's fair in which U.S. city?", options: ["Portland", "Seattle", "San Francisco", "Vancouver"], correctIndex: 1, explanation: "The futuristic tower became a symbol of the Pacific Northwest.", hint: "Pike Place Market is downtown."),
        TriviaItem(id: "lm7c", prompt: "Niagara Falls actually consists of three falls; Horseshoe Falls is mostly on which side?", options: ["United States only", "Canada", "Split equally", "Mexico"], correctIndex: 1, explanation: "The curved cataract lies largely in Ontario.", hint: "Think of the province north of New York state."),
        TriviaItem(id: "lm7d", prompt: "The Gateway Arch in St. Louis symbolizes westward expansion and is made primarily of what?", options: ["Concrete", "Stainless steel", "Wood", "Brick"], correctIndex: 1, explanation: "Eero Saarinen designed the weighted catenary curve.", hint: "Shiny metal catenary on the Mississippi."),
        TriviaItem(id: "lm7e", prompt: "The ancient Maya city of Tikal features steep pyramids rising from rainforest in which country?", options: ["Guatemala", "Cuba", "Panama", "Colombia"], correctIndex: 0, explanation: "The UNESCO site lies in Petén department.", hint: "Central American nation south of Mexico."),
    ]

    private static let level8: [TriviaItem] = [
        TriviaItem(id: "lm8a", prompt: "The Iguazu Falls system straddles Brazil and which other country?", options: ["Chile", "Argentina", "Uruguay", "Paraguay"], correctIndex: 1, explanation: "Hundreds of cascades spread through subtropical rainforest.", hint: "Buenos Aires is the capital of the neighbor."),
        TriviaItem(id: "lm8b", prompt: "Easter Island is administered by which South American country?", options: ["Peru", "Chile", "Ecuador", "Bolivia"], correctIndex: 1, explanation: "It lies far west in Polynesia but is a special territory.", hint: "Long narrow Andean republic."),
        TriviaItem(id: "lm8c", prompt: "The Panama Canal connects which two oceans?", options: ["Indian and Pacific", "Atlantic and Pacific", "Arctic and Atlantic", "Pacific and Southern"], correctIndex: 1, explanation: "Locks lift ships across the Isthmus of Panama.", hint: "Cuts through Central America."),
        TriviaItem(id: "lm8d", prompt: "Christ the Redeemer stands within which urban forested peaks?", options: ["Andes cordillera", "Tijuca National Park", "Amazon basin", "Pampas"], correctIndex: 1, explanation: "Corcovado Mountain rises above the Atlantic metropolis.", hint: "Same city as Copacabana beach."),
        TriviaItem(id: "lm8e", prompt: "The historic center of Cartagena with colonial walls faces which sea?", options: ["Pacific Ocean", "Caribbean Sea", "Atlantic south of Brazil", "Gulf of Mexico"], correctIndex: 1, explanation: "Spanish fortifications protected the treasure port.", hint: "Northern coast of Colombia."),
    ]

    private static let level9: [TriviaItem] = [
        TriviaItem(id: "lm9a", prompt: "The Forbidden City served as the imperial palace in which capital?", options: ["Xi'an", "Beijing", "Nanjing", "Shanghai"], correctIndex: 1, explanation: "Ming and Qing emperors ruled from its walled courtyards.", hint: "Tiananmen Square adjoins it."),
        TriviaItem(id: "lm9b", prompt: "Fushimi Inari Shrine near Kyoto is famous for thousands of what?", options: ["Stone lanterns", "Torii gates", "Cherry trees", "Bronze bells"], correctIndex: 1, explanation: "Vermilion gates line paths up Mount Inari.", hint: "Fox messengers in Shinto tradition."),
        TriviaItem(id: "lm9c", prompt: "The Lotus Temple in New Delhi is shaped like a flower and welcomes which practice?", options: ["Single exclusive faith", "All religions in quiet prayer", "Only silent meditation by monks", "Political assemblies"], correctIndex: 1, explanation: "Bahá'í House of Worship emphasizes unity of worship.", hint: "Marble petals, open to every background."),
        TriviaItem(id: "lm9d", prompt: "The Petronas Twin Towers were once the world's tallest buildings in which capital?", options: ["Jakarta", "Kuala Lumpur", "Manila", "Bangkok"], correctIndex: 1, explanation: "A skybridge links the two stainless-steel clad towers.", hint: "Federal capital of Malaysia."),
        TriviaItem(id: "lm9e", prompt: "The Winter Palace on the Neva River is central to which museum complex?", options: ["Louvre", "Hermitage", "Prado", "British Museum"], correctIndex: 1, explanation: "Catherine the Great expanded the art collections.", hint: "Saint Petersburg, Russia."),
    ]

    private static let level10: [TriviaItem] = [
        TriviaItem(id: "lm10a", prompt: "The Blue Lagoon geothermal spa draws visitors near which Atlantic island nation's capital area?", options: ["Greenland", "Iceland", "Faroe Islands", "Svalbard"], correctIndex: 1, explanation: "Silica-rich water sits in a lava field near Grindavík.", hint: "Reykjavík is the hub."),
        TriviaItem(id: "lm10b", prompt: "The Cliffs of Moher rise along the west coast of which country?", options: ["Scotland", "Ireland", "Wales", "Norway"], correctIndex: 1, explanation: "They face the wild Atlantic south of Galway Bay.", hint: "County Clare landmark."),
        TriviaItem(id: "lm10c", prompt: "The Charles Bridge lined with statues crosses the Vltava in which city?", options: ["Budapest", "Prague", "Vienna", "Kraków"], correctIndex: 1, explanation: "Gothic towers guard the Old Town side.", hint: "Capital of the Czech Republic."),
        TriviaItem(id: "lm10d", prompt: "Plitvice Lakes National Park is known for travertine cascades in which country?", options: ["Slovenia", "Croatia", "Serbia", "Bosnia"], correctIndex: 1, explanation: "Boardwalks wind between turquoise pools.", hint: "Adriatic republic, Zagreb capital."),
        TriviaItem(id: "lm10e", prompt: "The monolithic churches of Lalibela are carved from living rock in which highland nation?", options: ["Kenya", "Ethiopia", "Eritrea", "Somalia"], correctIndex: 1, explanation: "They are a major pilgrimage destination.", hint: "Also home to Simien Mountains."),
    ]

    private static let level11: [TriviaItem] = [
        TriviaItem(id: "lm11a", prompt: "The Western Wall in Jerusalem is a remnant of which ancient structure?", options: ["Roman forum", "Second Temple platform", "Byzantine aqueduct", "Crusader castle"], correctIndex: 1, explanation: "It is a focus of prayer at the Temple Mount's western side.", hint: "Herodian retaining wall."),
        TriviaItem(id: "lm11b", prompt: "The Dome of the Rock's golden dome covers a shrine on which contested plateau?", options: ["Acropolis", "Temple Mount", "Capitol Hill", "Palatine Hill"], correctIndex: 1, explanation: "The octagonal building marks a site sacred to several faiths.", hint: "Old City of Jerusalem."),
        TriviaItem(id: "lm11c", prompt: "The Golden Temple (Harmandir Sahib) is the holiest gurdwara of Sikhism in which city?", options: ["Delhi", "Amritsar", "Lahore", "Chandigarh"], correctIndex: 1, explanation: "It surrounds a sacred pool in Punjab.", hint: "Northwestern India, near Pakistan border."),
        TriviaItem(id: "lm11d", prompt: "The Shwedagon Pagoda dominates the skyline of which former capital?", options: ["Bangkok", "Yangon", "Hanoi", "Phnom Penh"], correctIndex: 1, explanation: "The stupa is said to hold relics of past buddhas.", hint: "Myanmar's largest city."),
        TriviaItem(id: "lm11e", prompt: "The rock-cut temples of Abu Simbel were relocated in the 1960s to save them from which lake?", options: ["Lake Victoria", "Lake Nasser", "Dead Sea", "Aral Sea"], correctIndex: 1, explanation: "UNESCO led the engineering project before the High Dam flooded Nubia.", hint: "Aswan Dam reservoir."),
    ]

    private static let level12: [TriviaItem] = [
        TriviaItem(id: "lm12a", prompt: "The Guggenheim Museum Bilbao helped popularize which architect's sculptural titanium style?", options: ["Le Corbusier", "Frank Gehry", "Zaha Hadid", "Oscar Niemeyer"], correctIndex: 1, explanation: "The riverside museum reshaped urban renewal debates.", hint: "Canadian-American deconstructivist."),
        TriviaItem(id: "lm12b", prompt: "The Marina Bay Sands resort in Singapore is famous for a ship-like structure atop how many towers?", options: ["One", "Three", "Five", "Seven"], correctIndex: 1, explanation: "The SkyPark infinity pool spans the rooftop.", hint: "Moshe Safdie design."),
        TriviaItem(id: "lm12c", prompt: "The Lotus-shaped Arts Science Museum sits beside which Singapore waterfront district?", options: ["Clarke Quay", "Marina Bay", "Sentosa Cove", "Chinatown"], correctIndex: 1, explanation: "It is part of an integrated resort zone.", hint: "Helix Bridge nearby."),
        TriviaItem(id: "lm12d", prompt: "The Shard's glass pyramid pierces the skyline of which European capital?", options: ["Paris", "London", "Berlin", "Madrid"], correctIndex: 1, explanation: "Renzo Piano designed the tallest building in the United Kingdom.", hint: "Southwark, near London Bridge."),
        TriviaItem(id: "lm12e", prompt: "The CCTV Headquarters in Beijing is nicknamed for resembling what shape?", options: ["A sail", "A loop or arch", "A sphere", "A needle"], correctIndex: 1, explanation: "Rem Koolhaas's design challenges traditional tower forms.", hint: "Two leaning towers linked at top and bottom."),
    ]
}
