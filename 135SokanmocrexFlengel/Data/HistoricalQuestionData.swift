//
//  HistoricalQuestionData.swift
//  135SokanmocrexFlengel
//

import Foundation

enum HistoricalQuestionData {
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
        TriviaItem(id: "hh1a", prompt: "Which ancient civilization built pyramids along the Nile River?", options: ["Sumerians", "Egyptians", "Hittites", "Phoenicians"], correctIndex: 1, explanation: "Pharaohs commissioned monumental tombs for the afterlife.", hint: "Think of hieroglyphs."),
        TriviaItem(id: "hh1b", prompt: "The city-state of Athens is most associated with which ancient culture?", options: ["Persian Empire", "Greek world", "Carthage", "Etruscans"], correctIndex: 1, explanation: "Democratic experiments and philosophy flourished there.", hint: "Olympic Games ancient roots."),
        TriviaItem(id: "hh1c", prompt: "The Qin dynasty is known for unifying which large East Asian realm?", options: ["Japan", "China", "Korea", "Vietnam"], correctIndex: 1, explanation: "Standardized writing and roads followed conquest.", hint: "Great Wall segments expanded under later dynasties."),
        TriviaItem(id: "hh1d", prompt: "The Roman Republic transitioned toward empire around the life of which figure?", options: ["Pericles", "Julius Caesar", "Ashoka", "Hannibal"], correctIndex: 1, explanation: "Civil wars followed his crossing of the Rubicon.", hint: "Famous for Gallic campaigns and calendar reform."),
        TriviaItem(id: "hh1e", prompt: "Buddhism spread from northern India during the era of which ruler's missions?", options: ["Augustus", "Ashoka", "Cyrus", "Alexander"], correctIndex: 1, explanation: "Edicts on pillars promoted moral rule and tolerance.", hint: "Mauryan emperor."),
    ]

    private static let level2: [TriviaItem] = [
        TriviaItem(id: "hh2a", prompt: "The fall of the Western Roman Empire in 476 CE is traditionally linked to which Germanic leader?", options: ["Alaric", "Odoacer", "Attila", "Theodoric"], correctIndex: 1, explanation: "He deposed Romulus Augustulus, the last western emperor.", hint: "First king of Italy in this narrative."),
        TriviaItem(id: "hh2b", prompt: "The Magna Carta in 1215 limited royal power in which kingdom?", options: ["France", "England", "Poland", "Castile"], correctIndex: 1, explanation: "Barons pressed King John for written rights.", hint: "London is the capital."),
        TriviaItem(id: "hh2c", prompt: "The Black Death pandemic peaked in Europe during which century?", options: ["11th", "14th", "17th", "19th"], correctIndex: 1, explanation: "Bubonic plague spread along trade routes.", hint: "Between crusades and Renaissance."),
        TriviaItem(id: "hh2d", prompt: "The Ottoman Empire conquered Constantinople in which year?", options: ["1299", "1453", "1517", "1683"], correctIndex: 1, explanation: "Mehmed II used cannons against Theodosian walls.", hint: "Mid-15th century."),
        TriviaItem(id: "hh2e", prompt: "The voyages of Columbus across the Atlantic began under sponsorship of which crowns?", options: ["Portugal", "Spain", "England", "Genoa alone"], correctIndex: 1, explanation: "Isabella and Ferdinand backed the 1492 expedition.", hint: "Columbus Day debates reference this monarchy."),
    ]

    private static let level3: [TriviaItem] = [
        TriviaItem(id: "hh3a", prompt: "The American Declaration of Independence was adopted in which year?", options: ["1765", "1776", "1787", "1791"], correctIndex: 1, explanation: "The Continental Congress voted on July 4 in Philadelphia.", hint: "Between Lexington and the Constitution convention."),
        TriviaItem(id: "hh3b", prompt: "The French Revolution began with the storming of the Bastille in which year?", options: ["1783", "1789", "1799", "1815"], correctIndex: 1, explanation: "Parisians seized the fortress-prison in July.", hint: "Same decade as U.S. Constitution ratification."),
        TriviaItem(id: "hh3c", prompt: "Napoleon was finally defeated at Waterloo in which present-day country?", options: ["France", "Belgium", "Germany", "Netherlands"], correctIndex: 1, explanation: "Allied armies commanded by Wellington and Blücher prevailed.", hint: "Small nation between France and Germany."),
        TriviaItem(id: "hh3d", prompt: "The U.S. Civil War ended in which year?", options: ["1861", "1863", "1865", "1870"], correctIndex: 2, explanation: "Appomattox surrender came in April after four years of conflict.", hint: "Lincoln's second term began shortly before."),
        TriviaItem(id: "hh3e", prompt: "The Meiji Restoration accelerated industrialization in which country?", options: ["China", "Japan", "Korea", "Thailand"], correctIndex: 1, explanation: "Feudal domains gave way to centralized imperial rule after 1868.", hint: "Edo was renamed Tokyo."),
    ]

    private static let level4: [TriviaItem] = [
        TriviaItem(id: "hh4a", prompt: "World War I began in which year?", options: ["1905", "1914", "1917", "1939"], correctIndex: 1, explanation: "Assassination in Sarajevo triggered alliance mobilizations.", hint: "Archduke Franz Ferdinand."),
        TriviaItem(id: "hh4b", prompt: "The Russian Empire ended with abdication in which year?", options: ["1905", "1917", "1922", "1945"], correctIndex: 1, explanation: "February Revolution preceded Bolshevik takeover.", hint: "Same year as U.S. entered WWI."),
        TriviaItem(id: "hh4c", prompt: "The Wall Street Crash marking the Great Depression start is associated with which year?", options: ["1925", "1929", "1933", "1939"], correctIndex: 1, explanation: "Black Tuesday in October wiped out massive paper wealth.", hint: "Roaring Twenties end."),
        TriviaItem(id: "hh4d", prompt: "World War II in Europe is commonly dated ending in May of which year?", options: ["1943", "1944", "1945", "1946"], correctIndex: 2, explanation: "Germany signed unconditional surrender as Berlin fell.", hint: "Atomic bombs same year in Pacific."),
        TriviaItem(id: "hh4e", prompt: "India and Pakistan gained independence from British rule in which year?", options: ["1935", "1942", "1947", "1950"], correctIndex: 2, explanation: "Partition caused large-scale migration and violence.", hint: "Mid-1940s Asian decolonization."),
    ]

    private static let level5: [TriviaItem] = [
        TriviaItem(id: "hh5a", prompt: "The Berlin Wall opened for free crossing in which year?", options: ["1985", "1989", "1991", "1993"], correctIndex: 1, explanation: "November announcements led to crowds crossing checkpoints.", hint: "Same year as Romanian revolution."),
        TriviaItem(id: "hh5b", prompt: "Nelson Mandela was elected president of South Africa in which year?", options: ["1989", "1994", "1999", "2004"], correctIndex: 1, explanation: "First fully representative democratic election ended apartheid rule.", hint: "Mid-1990s."),
        TriviaItem(id: "hh5c", prompt: "The September 11 attacks on the United States occurred in which year?", options: ["1998", "2001", "2003", "2005"], correctIndex: 1, explanation: "Commercial airliners were used against landmark towers and the Pentagon.", hint: "Start of the millennium."),
        TriviaItem(id: "hh5d", prompt: "The United Kingdom voted to leave the European Union in a referendum held in which year?", options: ["2012", "2014", "2016", "2018"], correctIndex: 2, explanation: "Brexit negotiations followed the narrow public vote.", hint: "Same year as U.S. presidential election with Trump."),
        TriviaItem(id: "hh5e", prompt: "The WHO declared COVID-19 a pandemic in which month and year?", options: ["January 2019", "March 2020", "June 2021", "December 2022"], correctIndex: 1, explanation: "Global lockdowns and travel bans followed rapidly.", hint: "Early pandemic spring in the northern hemisphere."),
    ]

    private static let level6: [TriviaItem] = [
        TriviaItem(id: "hh6a", prompt: "Johannes Gutenberg's movable-type printing spread from which region in the mid-15th century?", options: ["Iberia", "German-speaking lands", "Italy only", "England only"], correctIndex: 1, explanation: "Mainz workshops catalyzed the print revolution.", hint: "Holy Roman Empire city on the Rhine."),
        TriviaItem(id: "hh6b", prompt: "The fall of Constantinople to Ottoman forces occurred in which year?", options: ["1299", "1453", "1492", "1529"], correctIndex: 1, explanation: "Scholars fleeing east helped spark Italian Renaissance debates.", hint: "Same century as end of Hundred Years' War."),
        TriviaItem(id: "hh6c", prompt: "Columbus sailed under Spanish sponsorship and reached Caribbean islands in which year?", options: ["1488", "1492", "1500", "1519"], correctIndex: 1, explanation: "His first voyage touched the Bahamas and Hispaniola.", hint: "Same year Granada fell to Catholic monarchs."),
        TriviaItem(id: "hh6d", prompt: "Martin Luther's Ninety-five Theses protest is traditionally dated to which year?", options: ["1415", "1517", "1545", "1618"], correctIndex: 1, explanation: "The Wittenberg debate ignited Protestant reform movements.", hint: "October door posting legend."),
        TriviaItem(id: "hh6e", prompt: "The Spanish Armada attempted invasion of England in which year?", options: ["1588", "1607", "1642", "1704"], correctIndex: 0, explanation: "Storms and English fireships disrupted the great fleet.", hint: "Elizabeth I speech at Tilbury era."),
    ]

    private static let level7: [TriviaItem] = [
        TriviaItem(id: "hh7a", prompt: "The Mayflower Pilgrims founded Plymouth Colony in which year?", options: ["1607", "1620", "1630", "1649"], correctIndex: 1, explanation: "Separatists sought religious freedom across the Atlantic.", hint: "After Jamestown, before Massachusetts Bay great migration."),
        TriviaItem(id: "hh7b", prompt: "The Peace of Westphalia ended which devastating conflict in 1648?", options: ["Hundred Years' War", "Thirty Years' War", "Seven Years' War", "Crimean War"], correctIndex: 1, explanation: "Treaties shaped notions of state sovereignty in Europe.", hint: "Central Europe, Catholic–Protestant devastation."),
        TriviaItem(id: "hh7c", prompt: "The English Bill of Rights following the Glorious Revolution was adopted in which year?", options: ["1649", "1689", "1707", "1776"], correctIndex: 1, explanation: "It limited royal power after William and Mary took the throne.", hint: "Between James II flight and Act of Union debates."),
        TriviaItem(id: "hh7d", prompt: "The steam engine improvements of James Watt helped launch which broader transformation?", options: ["Agricultural revolution only", "Industrial Revolution", "Digital revolution", "Green revolution"], correctIndex: 1, explanation: "Factories and railways scaled on coal power.", hint: "Late 18th-century British mills."),
        TriviaItem(id: "hh7e", prompt: "The storming of the Bastille in Paris occurred on 14 July of which year?", options: ["1776", "1789", "1799", "1804"], correctIndex: 1, explanation: "The date remains France's national holiday.", hint: "Same year as U.S. Constitution framework."),
    ]

    private static let level8: [TriviaItem] = [
        TriviaItem(id: "hh8a", prompt: "Napoleon crowned himself Emperor of the French in which year?", options: ["1799", "1804", "1812", "1815"], correctIndex: 1, explanation: "The ceremony in Notre-Dame asserted new imperial legitimacy.", hint: "Before Austerlitz, after consulate."),
        TriviaItem(id: "hh8b", prompt: "Simón Bolívar was a leading liberator of Spanish colonies in which continent?", options: ["Africa", "South America", "Australia", "Asia"], correctIndex: 1, explanation: "Gran Colombia briefly united Venezuela, Colombia, Ecuador, and Panama.", hint: "Andean and Orinoco campaigns."),
        TriviaItem(id: "hh8c", prompt: "The Congress of Vienna redrew Europe after the defeat of Napoleon in which year?", options: ["1805", "1815", "1830", "1848"], correctIndex: 1, explanation: "Diplomats sought balance of power and restored monarchies.", hint: "Waterloo year."),
        TriviaItem(id: "hh8d", prompt: "The Seneca Falls Convention launching the U.S. women's rights movement was held in which year?", options: ["1820", "1848", "1865", "1920"], correctIndex: 1, explanation: "Organizers issued declarations echoing revolutionary ideals.", hint: "Same year as European revolutions wave."),
        TriviaItem(id: "hh8e", prompt: "Charles Darwin published On the Origin of Species in which year?", options: ["1831", "1859", "1871", "1905"], correctIndex: 1, explanation: "Natural selection debates reshaped biology and society.", hint: "Before U.S. Civil War."),
    ]

    private static let level9: [TriviaItem] = [
        TriviaItem(id: "hh9a", prompt: "Abraham Lincoln issued the Emancipation Proclamation during which year of the U.S. Civil War?", options: ["1861", "1863", "1865", "1867"], correctIndex: 1, explanation: "It reframed Union war aims toward abolition in rebelling states.", hint: "After Antietam."),
        TriviaItem(id: "hh9b", prompt: "The Suez Canal opened to shipping in which year?", options: ["1848", "1869", "1882", "1914"], correctIndex: 1, explanation: "It shortened Europe–India routes dramatically.", hint: "Same decade as Franco-Prussian War."),
        TriviaItem(id: "hh9c", prompt: "Germany unified as an empire under Prussian leadership in which year?", options: ["1848", "1871", "1914", "1933"], correctIndex: 1, explanation: "Versailles Hall of Mirrors hosted the proclamation.", hint: "After Franco-Prussian War."),
        TriviaItem(id: "hh9d", prompt: "The Scramble for Africa intensified after the Berlin Conference of which year?", options: ["1878", "1884–1885", "1898", "1905"], correctIndex: 1, explanation: "European powers set rules for claiming African territories.", hint: "Bismarck hosted."),
        TriviaItem(id: "hh9e", prompt: "The Wright brothers achieved powered flight at Kitty Hawk in which year?", options: ["1898", "1903", "1911", "1927"], correctIndex: 1, explanation: "Their biplane flights lasted seconds but proved control in the air.", hint: "Start of twentieth century."),
    ]

    private static let level10: [TriviaItem] = [
        TriviaItem(id: "hh10a", prompt: "The October Revolution brought Bolsheviks to power in Russia in which year?", options: ["1905", "1917", "1921", "1928"], correctIndex: 1, explanation: "Dual calendar dating means November in the Gregorian calendar.", hint: "Same year as U.S. entry into WWI."),
        TriviaItem(id: "hh10b", prompt: "The Treaty of Versailles formally ended World War I for Germany in which year?", options: ["1917", "1919", "1923", "1939"], correctIndex: 1, explanation: "War guilt clauses and reparations fueled later resentment.", hint: "Paris peace conference."),
        TriviaItem(id: "hh10c", prompt: "Women gained voting rights nationwide in the United States with the 19th Amendment ratified in which year?", options: ["1910", "1920", "1932", "1945"], correctIndex: 1, explanation: "Decades of suffrage campaigns culminated in ratification.", hint: "Roaring Twenties start."),
        TriviaItem(id: "hh10d", prompt: "Mahatma Gandhi launched the Salt March to protest British salt taxes in which year?", options: ["1919", "1930", "1942", "1947"], correctIndex: 1, explanation: "Civil disobedience drew global attention to Indian independence.", hint: "Between civil disobedience campaigns."),
        TriviaItem(id: "hh10e", prompt: "Japan attacked Pearl Harbor drawing the United States into World War II in which year?", options: ["1939", "1941", "1943", "1945"], correctIndex: 1, explanation: "December 7 attacks unified American war opinion.", hint: "After lend-lease, before Midway."),
    ]

    private static let level11: [TriviaItem] = [
        TriviaItem(id: "hh11a", prompt: "The State of Israel declared independence in which year?", options: ["1939", "1948", "1956", "1967"], correctIndex: 1, explanation: "Partition plans and regional war followed British withdrawal.", hint: "Same year Gandhi was assassinated."),
        TriviaItem(id: "hh11b", prompt: "Mao Zedong proclaimed the People's Republic of China in which year?", options: ["1937", "1949", "1953", "1966"], correctIndex: 1, explanation: "Civil war concluded with Nationalist retreat to Taiwan.", hint: "After WWII, before Korean War."),
        TriviaItem(id: "hh11c", prompt: "The Korean War began with northern invasion in which year?", options: ["1945", "1950", "1955", "1960"], correctIndex: 1, explanation: "UN forces under U.S. leadership intervened for the south.", hint: "Start of the 1950s."),
        TriviaItem(id: "hh11d", prompt: "Algeria won independence from France after a long war in which year?", options: ["1954", "1962", "1970", "1975"], correctIndex: 1, explanation: "Evian Accords ended French Algeria.", hint: "Same decade as African decolonization wave."),
        TriviaItem(id: "hh11e", prompt: "The Cuban Missile Crisis brought superpowers to the brink in which year?", options: ["1956", "1962", "1968", "1979"], correctIndex: 1, explanation: "Secret Soviet missiles in Cuba triggered a naval quarantine.", hint: "Kennedy administration."),
    ]

    private static let level12: [TriviaItem] = [
        TriviaItem(id: "hh12a", prompt: "Apollo 11 astronauts first walked on the Moon in which year?", options: ["1965", "1969", "1972", "1981"], correctIndex: 1, explanation: "Neil Armstrong and Buzz Aldrin landed in the Sea of Tranquility.", hint: "Woodstock summer."),
        TriviaItem(id: "hh12b", prompt: "Nelson Mandela was released from prison in South Africa in which year?", options: ["1985", "1990", "1994", "1999"], correctIndex: 1, explanation: "Negotiations toward multiracial elections accelerated.", hint: "Start of the last decade of the 20th century."),
        TriviaItem(id: "hh12c", prompt: "The Soviet Union formally dissolved in which year?", options: ["1989", "1991", "1993", "1999"], correctIndex: 1, explanation: "Russia inherited the UN Security Council seat.", hint: "Christmas week announcements."),
        TriviaItem(id: "hh12d", prompt: "Hong Kong's sovereignty transferred from the United Kingdom to China in which year?", options: ["1984", "1997", "2003", "2014"], correctIndex: 1, explanation: "'One country, two systems' framed the handover.", hint: "Same year as Asian financial crisis."),
        TriviaItem(id: "hh12e", prompt: "The Paris Agreement on climate change was adopted by UN parties in which year?", options: ["2009", "2015", "2019", "2021"], correctIndex: 1, explanation: "Nationally determined contributions became the core pledge model.", hint: "COP21 year."),
    ]
}
