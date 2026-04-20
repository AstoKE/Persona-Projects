import { PRIORITY_COLORS, CATEGORY_COLORS } from '../Interfaces/Task'

/**
 * ItemCard – Tek bir görev kartı.
 * Props:
 *   task        – Task nesnesi
 *   onDelete()  – silme callback
 *   onEdit()    – düzenleme callback
 *   onToggle()  – tamamlandı toggle callback
 */
export default function ItemCard({ task, onDelete, onEdit, onToggle }) {
  const date = new Date(task.createdAt).toLocaleDateString('tr-TR')

  return (
    <div
      className={`bg-white rounded-xl shadow-sm border-l-4 p-4 flex flex-col gap-3
                  transition-all hover:shadow-md
                  ${task.completed ? 'border-green-400 opacity-70' : 'border-blue-500'}`}
    >
      {/* Başlık + tamamlandı checkbox */}
      <div className="flex items-start gap-3">
        <input
          type="checkbox"
          checked={task.completed}
          onChange={() => onToggle(task.id)}
          className="mt-1 w-4 h-4 accent-blue-600 cursor-pointer"
        />
        <span
          className={`text-sm font-semibold leading-snug flex-1
                      ${task.completed ? 'line-through text-gray-400' : 'text-gray-800'}`}
        >
          {task.title}
        </span>
      </div>

      {/* Etiketler */}
      <div className="flex flex-wrap gap-2">
        <span className={`text-xs font-medium px-2 py-0.5 rounded-full
                          ${CATEGORY_COLORS[task.category] ?? 'bg-gray-100 text-gray-600'}`}>
          {task.category}
        </span>
        <span className={`text-xs font-medium px-2 py-0.5 rounded-full
                          ${PRIORITY_COLORS[task.priority] ?? 'bg-gray-100 text-gray-600'}`}>
          {task.priority}
        </span>
        {task.completed && (
          <span className="text-xs font-medium px-2 py-0.5 rounded-full bg-green-100 text-green-700">
            Tamamlandı ✓
          </span>
        )}
      </div>

      {/* Tarih + Aksiyonlar */}
      <div className="flex items-center justify-between">
        <span className="text-xs text-gray-400">{date}</span>
        <div className="flex gap-2">
          <button
            onClick={() => onEdit(task)}
            className="text-xs px-3 py-1 bg-yellow-100 hover:bg-yellow-200
                       text-yellow-800 rounded-lg font-medium transition-colors"
          >
            Düzenle
          </button>
          <button
            onClick={() => onDelete(task.id)}
            className="text-xs px-3 py-1 bg-red-100 hover:bg-red-200
                       text-red-700 rounded-lg font-medium transition-colors"
          >
            Sil
          </button>
        </div>
      </div>
    </div>
  )
}
