import SwiftUI

struct HabitDetailView: View {
    @Binding var habit: Habit
    var onSave: (() -> Void)?  // isteğe bağlı kaydetme callback'i

    var body: some View {
        VStack {
            Text(habit.title)
                .font(.largeTitle)
                .padding()

            Button {
                let today = Calendar.current.startOfDay(for: Date())
                if !habit.completedDays.contains(today) {
                    habit.completedDays.append(today)
                    onSave?() // ana ekrandan gelen kaydetme fonksiyonunu çağır
                }
            } label: {
                Text("Bugünü Tamamla")
                    .foregroundColor(Color("ArticleColor")) // metin rengi assetimden
                    .fontWeight(.semibold)
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(Color("AccentColorPinkBlue")) // arka plan rengi belirlediğim assetimdenn

            NavigationLink {
                HabitProgressView(habit: habit)
            } label: {
                Text("İlerleme Sürecini Gör")
                    .foregroundColor(Color("ArticleColor"))
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("AccentColorPinkBlue"))
            .padding(.top, 10)

            List(habit.completedDays, id: \.self) { date in
                Text(date.formatted(date: .abbreviated, time: .omitted))
            }

            Spacer()
        }
        .navigationTitle("Alışkanlık Takibi")
        .tint(Color("ArticleColor"))
    }
}
