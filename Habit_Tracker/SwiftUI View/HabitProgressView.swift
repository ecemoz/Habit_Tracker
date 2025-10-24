import SwiftUI
import Charts

struct HabitProgressView: View {
    var habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(habit.title) İlerlemesi")
                .font(.title2)
                .padding(.bottom)
                .foregroundStyle(Color("ArticleColor"))
            
            if habit.completedDays.isEmpty {
                Text("Henüz tamamlanan gün yok.")
                    .foregroundColor(Color("ArticleColor"))
            } else {
                Chart {
                    ForEach(habit.completedDays, id: \.self) { date in
                        BarMark(
                            x: .value("Tarih", date, unit: .day),
                            y: .value("Tamamlandı", 1)
                        )
                    }
                }
                .frame(height: 200)
                // X ekseni stil ve renklerimmm
                .chartXAxis {
                    AxisMarks(preset: .automatic, position: .automatic) { _ in
                        AxisGridLine().foregroundStyle(Color("GrafikXY").opacity(0.50))
                        AxisTick().foregroundStyle(Color("GrafikXY"))
                        AxisValueLabel().foregroundStyle(Color("GrafikXY"))
                    }
                }
                // Y ekseni stil ve renklerimm
                .chartYAxis {
                    AxisMarks(preset: .automatic, position: .automatic) { _ in
                        AxisGridLine().foregroundStyle(Color("GrafikXY").opacity(0.50))
                        AxisTick().foregroundStyle(Color("GrafikXY"))
                        AxisValueLabel().foregroundStyle(Color("GrafikXY"))
                    }
                }
                //Eksen başlıklarını göstermek istedim
                .chartXAxisLabel("Tarih", alignment: .center)
                .foregroundStyle(Color("GrafikXY"))
                .chartYAxisLabel("Tamamlandı", alignment: .center)
                .foregroundStyle(Color("GrafikXY"))
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Alışkanlık Grafiği")
        .tint(Color("ArticleColor"))
    }
}
