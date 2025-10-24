import SwiftUI

//Uygulamamın ana ekranını tanımlıyorum. Kullanıcımın karşısına bu ekran gelecek.
struct ContentView: View {
    @State private var habits: [Habit] = [] //Kullanıcımın tüm alışkanlıklarını bu listede buraya tutacağım - habits
    @State private var newHabitTitle = "" // Kullanıcımın yeni alışkanlık ekle alanına yazdığı metin - newHabitTitle
//State - Bir değişken değiştiğinde otomatik olarak yenilememize yarıyor.

    var body: some View {
        NavigationStack { //Ekranlar arasıdaki geçişi sağlamak istiyorum.
            VStack { //Üst üste koyduğum parçalar için
                HStack {
                    TextField("Yeni alışkanlık ekle", text: $newHabitTitle) //Kullanıcımın yazı girebildiği alan // $ bu ile buraya kullanıcım birşey yazdığında ben direkt onu newHabitTitle değişkenine bağlamak istedim.
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Ekle") { // Ekle yazılı butonum
                        guard !newHabitTitle.isEmpty else { return }
                        let habit = Habit(title: newHabitTitle)
                        habits.append(habit)
                        newHabitTitle = ""
                        saveHabits()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()

                //Her alışkanlık kısmım için bir satır oluşturmak istedim.
                List {
                    ForEach(habits) { habit in //satıra tıklayınca  alışkanlık detay ekranına gitmesini istiyorum- navigation link ile
                        NavigationLink(destination: HabitDetailView(habit: binding(for: habit))) {
                            Text(habit.title) //alışkanlığımı satırda göstermek istiyorum.
                        }
                    }
                    .onDelete(perform: deleteHabit) //sola kaydırarak silme özelliği eklemek istedim.
                }
            }
            .navigationTitle("Alışkanlıklarım")
        }
        .onAppear(perform: loadHabits)
    }

    //detay ekranına gitmem için seçilen alışkanlığı buldurmak istiyorum.
    func binding(for habit: Habit) -> Binding<Habit> {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else {
            fatalError("Habit not found")
        }
        return $habits[index]
    }
   
    //kullanıcım listede sola kaydırıp sil dirse alışkanlık listeden çıkarılır.
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
    }

    //burada artık listeyi telefona kaydedicek.
    func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "Habits")
        }
    }

    //uygulamayı açtığımda eski alışkanlıkları geri bulmak istiyorum.
    func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: "Habits"),
           let decoded = try? JSONDecoder().decode([Habit].self, from: savedData) {
            habits = decoded
        }
    }
}
