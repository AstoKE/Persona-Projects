import { useState } from 'react'
import ItemCard from './ItemCard'
import { CATEGORIES, PRIORITIES } from '../Interfaces/Task'

/**
 * ItemList – Görev listesi + filtreleme/arama bileşeni.
 * Props:
 *   tasks      – Task[]
 *   onDelete() – silme callback
 *   onEdit()   – düzenleme callback
 *   onToggle() – toggle callback
 */
export default function ItemList({ tasks, onDelete, onEdit, onToggle }) {
  const [search,   setSearch]   = useState('')
  const [filterCat, setFilterCat] = useState('Tümü')
  const [filterPri, setFilterPri] = useState('Tümü')
  const [filterDone, setFilterDone] = useState('Tümü')

  const filtered = tasks.filter(t => {
    const matchSearch = t.title.toLowerCase().includes(search.toLowerCase())
    const matchCat    = filterCat  === 'Tümü' || t.category === filterCat
    const matchPri    = filterPri  === 'Tümü' || t.priority === filterPri
    const matchDone   =
      filterDone === 'Tümü'       ? true :
      filterDone === 'Tamamlanan' ? t.completed :
                                    !t.completed
    return matchSearch && matchCat && matchPri && matchDone
  })

  const total     = tasks.length
  const completed = tasks.filter(t => t.completed).length

  return (
    <div>
      {/* İstatistik */}
      <div className="flex gap-4 mb-4">
        {[
          { label: 'Toplam',      value: total,           color: 'bg-blue-50 text-blue-700' },
          { label: 'Tamamlanan',  value: completed,        color: 'bg-green-50 text-green-700' },
          { label: 'Bekleyen',    value: total - completed, color: 'bg-yellow-50 text-yellow-700' },
        ].map(s => (
          <div key={s.label} className={`flex-1 rounded-xl p-3 text-center ${s.color}`}>
            <p className="text-2xl font-bold">{s.value}</p>
            <p className="text-xs font-medium">{s.label}</p>
          </div>
        ))}
      </div>

      {/* Arama + Filtreler */}
      <div className="bg-white rounded-2xl shadow-sm p-4 mb-4 flex flex-wrap gap-3">
        <input
          type="text"
          value={search}
          onChange={e => setSearch(e.target.value)}
          placeholder="Görev ara..."
          className="flex-1 min-w-[160px] border border-gray-300 rounded-lg px-3 py-2
                     text-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
        />
        <select
          value={filterCat}
          onChange={e => setFilterCat(e.target.value)}
          className="border border-gray-300 rounded-lg px-3 py-2 text-sm
                     focus:outline-none focus:ring-2 focus:ring-blue-400"
        >
          <option>Tümü</option>
          {CATEGORIES.map(c => <option key={c}>{c}</option>)}
        </select>
        <select
          value={filterPri}
          onChange={e => setFilterPri(e.target.value)}
          className="border border-gray-300 rounded-lg px-3 py-2 text-sm
                     focus:outline-none focus:ring-2 focus:ring-blue-400"
        >
          <option>Tümü</option>
          {PRIORITIES.map(p => <option key={p}>{p}</option>)}
        </select>
        <select
          value={filterDone}
          onChange={e => setFilterDone(e.target.value)}
          className="border border-gray-300 rounded-lg px-3 py-2 text-sm
                     focus:outline-none focus:ring-2 focus:ring-blue-400"
        >
          {['Tümü', 'Bekleyen', 'Tamamlanan'].map(o => <option key={o}>{o}</option>)}
        </select>
      </div>

      {/* Liste */}
      {filtered.length === 0 ? (
        <div className="text-center py-12 text-gray-400">
          <p className="text-4xl mb-2">📭</p>
          <p className="text-sm">Görev bulunamadı.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {filtered.map(task => (
            <ItemCard
              key={task.id}
              task={task}
              onDelete={onDelete}
              onEdit={onEdit}
              onToggle={onToggle}
            />
          ))}
        </div>
      )}
    </div>
  )
}
