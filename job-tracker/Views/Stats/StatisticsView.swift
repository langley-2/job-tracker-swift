//  StatisticsView.swift
//  job-tracker
//
//  Created by Langley Millard on 4/5/2025.
//


import SwiftUI

struct StatisticsView: View {
    @ObservedObject var jobStore: JobStore
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Application Summary")) {
                    HStack {
                        Text("Total Applications")
                        Spacer()
                        Text("\(jobStore.jobs.count)")
                            .bold()
                    }
                    
                    ForEach(JobStatus.allCases, id: \.self) { status in
                        HStack {
                            Text(status.rawValue)
                            Spacer()
                            Text("\(jobsWithStatus(status).count)")
                                .bold()
                                .foregroundColor(status.color)
                        }
                    }
                }
                
                // In a real app, you'd add more statistics sections
                Section(header: Text("Response Rate")) {
                    Text("Coming soon...")
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Timeline")) {
                    Text("Coming soon...")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Statistics")
        }
    }
    
    private func jobsWithStatus(_ status: JobStatus) -> [Job] {
        return jobStore.jobs.filter { $0.status == status }
    }
}
